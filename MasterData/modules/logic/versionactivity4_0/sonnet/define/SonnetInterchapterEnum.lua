-- chunkname: @modules/logic/versionactivity4_0/sonnet/define/SonnetInterchapterEnum.lua

module("modules.logic.versionactivity4_0.sonnet.define.SonnetInterchapterEnum", package.seeall)

local SonnetInterchapterEnum = _M

SonnetInterchapterEnum.WordStatus = {
	Used = 2,
	Locked = 0,
	Unlocked = 1,
	Consumed = 3
}
SonnetInterchapterEnum.PrefsKey = {
	NewWord = 1
}
SonnetInterchapterEnum.Audio = {
	play_ui_role_pieces_open = 400016,
	play_ui_wenming_cards_toushi_gone = 400013,
	play_ui_wulu_lucky_bag_prize = 400014,
	play_ui_wulu_paiqian_open = 400015,
	play_ui_molu_jlbn_open = 400012
}

return SonnetInterchapterEnum
