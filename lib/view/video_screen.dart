import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late VlcPlayerController _tsController;
  late VlcPlayerController _mp4Controller;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _tsController = VlcPlayerController.network(
      'https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8',
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );

    _mp4Controller = VlcPlayerController.network(
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );

    _tabController.addListener(() async {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0) {
        await _mp4Controller.pause();
        await _tsController.play();
      } else {
        await _tsController.pause();
        await _mp4Controller.play();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tsController.dispose();
    _mp4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('video_player'.tr()),
            centerTitle: true,
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            pinned: true,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              tabs: [
                Tab(text: 'ts_video'.tr()),
                Tab(text: 'mp4_video'.tr()),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            VideoTab(controller: _tsController),
            VideoTab(controller: _mp4Controller),
          ],
        ),
      ),
    );
  }
}

class VideoTab extends StatefulWidget {
  final VlcPlayerController controller;

  const VideoTab({super.key, required this.controller});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab>
    with AutomaticKeepAliveClientMixin {
  bool isPlaying = true;

  @override
  bool get wantKeepAlive => true;

  void _togglePlayPause() async {
    final playing = await widget.controller.isPlaying();
    if (playing == true) {
      await widget.controller.pause();
    } else {
      await widget.controller.play();
    }

    setState(() {
      isPlaying = !(playing ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updatePlayingState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updatePlayingState);
    super.dispose();
  }

  void _updatePlayingState() async {
    final playing = await widget.controller.isPlaying();
    if (mounted) {
      setState(() {
        isPlaying = playing ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: VlcPlayer(
            controller: widget.controller,
            aspectRatio: 16 / 9,
            placeholder: const Center(child: CircularProgressIndicator()),
          ),
        ),
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: _togglePlayPause,
          iconSize: 40,
          color: Colors.redAccent,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
