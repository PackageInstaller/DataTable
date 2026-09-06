-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacebuffselectView.lua

module("logic.extensions.nineplace.view.NineplacebuffselectView", package.seeall)

local NineplacebuffselectView = class("NineplacebuffselectView", TableViewComponent)

function NineplacebuffselectView:ctor()
	NineplacebuffselectView.super.ctor(self)

	self.currStageId = false
end

function NineplacebuffselectView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function NineplacebuffselectView:buildUI()
	NineplacebuffselectView.super.buildUI(self)

	self.upBuffBtn = self:getBtn("upBuffBtn")
	self.maskBg = GameUtil.asBtn(self:getGo("maskBg"))
end

function NineplacebuffselectView:bindEvents()
	NineplacebuffselectView.super.bindEvents(self)
	self.upBuffBtn:AddClickListener(self.onClickUpBuff, self)
	self.maskBg:AddClickListener(self.onClickClose, self)
end

function NineplacebuffselectView:unbindEvents()
	NineplacebuffselectView.super.unbindEvents(self)
	self.upBuffBtn:RemoveClickListener()
	self.maskBg:RemoveClickListener()
end

function NineplacebuffselectView:destroyUI()
	NineplacebuffselectView.super.destroyUI(self)
end

function NineplacebuffselectView:onEnter()
	NineplacebuffselectView.super.onEnter(self)

	self.currStageId = false
	self.parm = self:getOpenParam()
	self._formStrengthInfos = nil

	if self.parm then
		self._formStrengthInfos = self.parm[1]
		self.currStageId = self.parm[2]

		if self.parm[3] == "closeUp" then
			goutil.setActive(self.upBuffBtn.gameObject, false)
		end
	end

	self:initView()
end

function NineplacebuffselectView:onEnterFinished()
	NineplacebuffselectView.super.onEnterFinished(self)
end

function NineplacebuffselectView:onExit()
	NineplacebuffselectView.super.onExit(self)

	if self.currStageId then
		-- block empty
	end
end

function NineplacebuffselectView:onExitFinished()
	NineplacebuffselectView.super.onExitFinished(self)
end

function NineplacebuffselectView:initView()
	self._curViewDatas = NinePlaceConfig.instance:getStageCfgs()

	self:reloadData()
end

function NineplacebuffselectView:getFormStrengthInfo(formStrengthId)
	if self._formStrengthInfos then
		return self._formStrengthInfos[formStrengthId]
	end
end

function NineplacebuffselectView:_updateCell(view, cell, cfg)
	local nameText = goutil.findChild(cell.gameObject, "nameText"):GetComponent(goutil.Type_UIText)
	local buffText = goutil.findChild(cell.gameObject, "buffText"):GetComponent(goutil.Type_UIText)
	local btn = GameUtil.asBtn(goutil.findChild(cell.gameObject, "raycast"))
	local lock = goutil.findChild(cell.gameObject, "imgLock")
	local icon = goutil.findChild(cell.gameObject, "imgIcon")
	local imgChange = goutil.findChild(cell.gameObject, "imgBg"):GetComponent("UIImageSpriteChange")
	local imgTrue = goutil.findChild(cell.gameObject, "imgTrue")
	local info = self:getFormStrengthInfo(cfg.stageId)
	local lightList = {}
	local place = goutil.findChild(cell.gameObject, "place")

	for i = 1, 9 do
		lightList[i] = goutil.findChild(place, "cell" .. i):GetComponent(ComponentType.UIImageSpriteChange)
	end

	local tempList = {}

	for i, v in ipairs(cfg.lights) do
		tempList[v] = true
	end

	for i, v in ipairs(lightList) do
		v:SetState(tempList[i] and 1 or 0)
	end

	buffText.text = ""
	nameText.text = cfg.name

	if info then
		local lcfg = BattleConfig.instance:getFormStrengthLvCfg(info.formStrengthId, info.formStrengthLv)
		local list = FightingPowerFormula.instance:parseAttrValues(lcfg.properties)
		local str = ""

		for i, v in pairs(list) do
			local name, value, symbol = GameUtil.getPropertyInfo(i, v)

			str = str .. name .. " " .. symbol .. value .. "  "
		end

		buffText.text = str
	end

	GameUtil.SetActive(lock, not info)
	GameUtil.SetActive(imgTrue, cfg.stageId == self.currStageId)
	imgChange:SetState(self.currStageId == cfg.stageId and 1 or 0)
	btn:RemoveClickListener()
	btn:AddClickListener(GameUtil.handler(self.onSwitchBuff, self, cfg))
end

function NineplacebuffselectView:onClickUpBuff()
	self:close()
	FuncOpenController.instance:openFunc(96)
end

function NineplacebuffselectView:onClickClose()
	self:close()
end

function NineplacebuffselectView:onSwitchBuff(cfg)
	if not cfg then
		return
	end

	local info = self:getFormStrengthInfo(cfg.stageId)

	if not info then
		FloatWordMgr.instance:show(cfg.buffLockTip)

		return
	end

	self.currStageId = cfg.stageId

	GlobalDispatcher:dispatch(GlobalNotify.BuffFormSelect, info.formStrengthId)
	self:close()
end

return NineplacebuffselectView
