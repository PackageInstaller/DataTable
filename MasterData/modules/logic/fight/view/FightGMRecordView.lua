-- chunkname: @modules/logic/fight/view/FightGMRecordView.lua

module("modules.logic.fight.view.FightGMRecordView", package.seeall)

local FightGMRecordView = class("FightGMRecordView", BaseView)
local GMTextSave = "保存战斗录像"

function FightGMRecordView:ctor()
	self._goGM = nil
	self._btnGM = nil
end

function FightGMRecordView:onOpen()
	if not isDebugBuild and not GMBattleModel.instance.enableGMFightRecord then
		return
	end

	self._goGM = GMController.instance:getGMNode("mainview", self.viewGO)
	self._goGM.name = "gm_fight_record"

	if self._goGM then
		local img = gohelper.findChildImage(self._goGM, "#btn_gm")

		recthelper.setWidth(img.transform, 200)

		self._txtName = gohelper.findChildText(self._goGM, "#btn_gm/Text")
		self._txtName.text = GMTextSave
		self._btnGM = gohelper.findChildClickWithAudio(self._goGM, "#btn_gm")

		self._btnGM:AddClickListener(self._onClickGM, self)
	end
end

function FightGMRecordView:_onClickGM()
	FightGMRecordView.saveRecord()
end

function FightGMRecordView.saveRecord()
	if GMBattleModel.instance.fightRecordMsg then
		local mo = ProtoTestCaseMO.New()

		mo:initFromProto(-12599, GMBattleModel.instance.fightRecordMsg)

		local jsonTable = mo:serialize()

		jsonTable.struct = "FightWithRecordAllRequest"

		local fightParam = {}

		for k, v in pairs(FightModel.instance:getFightParam()) do
			if type(v) ~= "table" then
				fightParam[k] = v
			end
		end

		jsonTable.fightParam = fightParam

		local jsonStr = cjson.encode(jsonTable)

		WindowsUtil.saveContentToFile(GMTextSave, jsonStr, "fightrecord", "json")
	end
end

function FightGMRecordView:removeEvents()
	if self._btnGM then
		self._btnGM:RemoveClickListener()
	end
end

return FightGMRecordView
