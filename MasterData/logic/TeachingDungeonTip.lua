-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingDungeonTip.lua

module("logic.extensions.teachingdungeon.view.TeachingDungeonTip", package.seeall)

local TeachingDungeonTip = class("TeachingDungeonTip", ViewComponent)

function TeachingDungeonTip:ctor()
	TeachingDungeonTip.super.ctor(self)
end

function TeachingDungeonTip:destroyUI()
	TeachingDungeonTip.super.destroyUI(self)
end

function TeachingDungeonTip:onExitFinished()
	TeachingDungeonTip.super.onExitFinished(self)
end

function TeachingDungeonTip:onEnterFinished()
	TeachingDungeonTip.super.onEnterFinished(self)
end

function TeachingDungeonTip:unbindEvents()
	TeachingDungeonTip.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function TeachingDungeonTip:bindEvents()
	TeachingDungeonTip.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function TeachingDungeonTip:onExit()
	TeachingDungeonTip.super.onExit(self)
	self._recordBtn:RemoveClickListener()
end

function TeachingDungeonTip:buildUI()
	TeachingDungeonTip.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "ScrollView/Viewport/Content")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._trContent = self:getGo("ScrollView/Viewport/Content").transform
	self._imgRole = self:getGo("imgRole")
	self._recordBtn = self:getBtn("recordBtn")
end

function TeachingDungeonTip:onEnter()
	TeachingDungeonTip.super.onEnter(self)

	local param = self:getFirstParam()

	if not param then
		return
	end

	self:_doWithParams(param)
end

function TeachingDungeonTip:_doWithParams(param)
	GameUtil.SetActive(self._recordBtn, false)

	if param.tag == 1 then
		local isFail = param.isFail

		self._techStageId = param.stageId

		local cfg = TeachingDungeonConfig.instance:getMonsterCfg(self._techStageId)

		if cfg then
			if not isFail then
				local str = ""

				if not cfg.description then
					str = cfg.faildescription or ""
				end

				self._txtTitle.text = "格兰特的指导"
				self._txtContent.text = str

				GameUtil.SetActive(self._recordBtn, isFail)
				self._recordBtn:AddClickListener(self.onClickRecord, self)
			end
		end
	elseif param.tag == 2 then
		local challengeId = param.challengeId
		local stageId = param.stageId
		local cfg = PetCollegeConfig.instance:getTeamCfgByStage(challengeId, stageId)

		self._txtContent.text = cfg.description
		self._txtTitle.text = cfg.name
	elseif param.tag == 3 then
		GameUtil.SetActive(self._recordBtn, false)

		local ruleCo = RulesConfig.instance:getRuleCo("herotrialrule")

		self._txtContent.text = ruleCo.rules
		self._txtTitle.text = "龙炎和你并肩作战"
	end
end

function TeachingDungeonTip:_onClickClose()
	self:close()
end

function TeachingDungeonTip:onClickRecord()
	self:close()

	if self._techStageId then
		BattleRecordRankController.instance:enterBattleRecoresView("bc_" .. self._techStageId)
	end
end

return TeachingDungeonTip
