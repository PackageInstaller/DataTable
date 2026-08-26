-- chunkname: @modules/logic/versionactivity3_5/lorentz/define/LorentzEnum.lua

module("modules.logic.versionactivity3_5.lorentz.define.LorentzEnum", package.seeall)

local LorentzEnum = _M

LorentzEnum.Rotation = {
	90,
	180,
	270,
	360
}
LorentzEnum.PuzzleType = {
	OnCrystal = 1,
	OutCrystal = 2
}
LorentzEnum.StateType = {
	Correct = 2,
	Normal = 1
}
LorentzEnum.LevelType = {
	Game = 2,
	Story = 1
}
LorentzEnum.BeForePlayGame = 1000
LorentzEnum.AfterPlayGame = 1001
LorentzEnum.PlaceRange = 1351001
LorentzEnum.TipRange = 1351002

return LorentzEnum
