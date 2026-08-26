-- chunkname: @modules/logic/room/define/RoomSummonEnum.lua

module("modules.logic.room.define.RoomSummonEnum", package.seeall)

local RoomSummonEnum = _M

RoomSummonEnum.SummonType = {
	ItemGet = 3,
	Summon = 1,
	Incubate = 2
}
RoomSummonEnum.SummonMode = {
	{
		CameraId = 2229,
		EggRoot = "1/v2a2_bxhy_simulate_kafeiguan_01/v2a2_bxhy_simulate_niudanji_01/mesh/scale",
		AudioId = AudioEnum.Room.play_ui_home_niudan1,
		EntityAnimKey = {
			operateEnd = "v2a2_simulate_kafeiguan_niudanji_01b",
			operatePre = "v2a2_simulate_kafeiguan_niudanji_01a",
			rare = {
				nil,
				nil,
				"v2a2_simulate_kafeiguan_niudanji_01c_s",
				"v2a2_simulate_kafeiguan_niudanji_01c_ss",
				"v2a2_simulate_kafeiguan_niudanji_01c_sss"
			}
		},
		RuleTipDesc = {
			titleen = "room_summon_critter_rule_tip_tilte_En",
			titlecn = "room_summon_critter_rule_tip_tilte",
			desc = "room_summon_critter_rule_tip"
		}
	},
	{
		CameraId = 2230,
		EggRoot = "1/v2a2_bxhy_simulate_kafeiguan_01/v2a2_bxhy_simulate_niudanji_02/mesh/scale",
		AudioId = AudioEnum.Room.play_ui_home_niudan3,
		EntityAnimKey = {
			operateEnd = "v2a2_simulate_kafeiguan_niudanji_02b",
			operatePre = "v2a2_simulate_kafeiguan_niudanji_02a",
			rare = {
				nil,
				nil,
				"v2a2_simulate_kafeiguan_niudanji_02c_s",
				"v2a2_simulate_kafeiguan_niudanji_02c_ss",
				"v2a2_simulate_kafeiguan_niudanji_02c_sss"
			}
		},
		RuleTipDesc = {
			titleen = "room_incubate_critter_rule_tip_tilte_En",
			titlecn = "room_incubate_critter_rule_tip_tilte",
			desc = "room_incubate_critter_rule_tip"
		}
	}
}

return RoomSummonEnum
