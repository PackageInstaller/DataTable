-- chunkname: @modules/audio/AkCallbackEnum.lua

module("modules.audio.AkCallbackEnum", package.seeall)

local AkCallbackEnum = _M

AkCallbackEnum.Type = {
	AK_EndOfEvent = 1,
	AK_MusicPlaylistSelect = 64,
	AK_MusicSyncBar = 512,
	AK_Marker = 4,
	AK_MusicSyncGrid = 4096,
	AK_EnableGetSourceStreamBuffering = 4194304,
	AK_EnableGetSourcePlayPosition = 1048576,
	AK_Monitoring = 536870912,
	AK_Starvation = 32,
	AK_Bank = 1073741824,
	AK_MusicSyncUserCue = 8192,
	AK_MusicSyncBeat = 256,
	AK_MusicPlayStarted = 128,
	AK_AudioInterruption = 570425344,
	AK_AudioSourceChange = 587202560,
	AK_MusicSyncPoint = 16384,
	AK_MusicSyncEntry = 1024,
	AK_MIDIEvent = 65536,
	AK_CallbackBits = 1048575,
	AK_SpeakerVolumeMatrix = 16,
	AK_EnableGetMusicPlayPosition = 2097152,
	AK_MusicSyncExit = 2048,
	AK_Duration = 8,
	AK_MusicSyncAll = 32512,
	AK_EndOfDynamicSequenceItem = 2
}

return AkCallbackEnum
