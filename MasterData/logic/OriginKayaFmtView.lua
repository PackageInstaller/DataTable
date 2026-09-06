-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/view/OriginKayaFmtView.lua

module("logic.extensions.originkaya.view.OriginKayaFmtView", package.seeall)

local OriginKayaFmtView = class("OriginKayaFmtView", ViewComponent)

function OriginKayaFmtView:ctor()
	OriginKayaFmtView.super.ctor(self)
end

function OriginKayaFmtView:unbindEvents()
	OriginKayaFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSeed)
end

function OriginKayaFmtView:bindEvents()
	OriginKayaFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSeed, self._onClickSeedInfo, self)
end

function OriginKayaFmtView:buildUI()
	OriginKayaFmtView.super.buildUI(self)

	self._info = self:getGo("info")
	self._btnSeed = self:getGo("btnSeed")
	self._btnClose = self:getGo("info/btnClose")
	self._tableview = self:getGo("info/tableview")
	self._tablecell = self:getGo("info/tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtSeedCount = self:getTxt("info/txtSeedCount")
end

function OriginKayaFmtView:onExit()
	OriginKayaFmtView.super.onExit(self)
end

function OriginKayaFmtView:onEnter()
	OriginKayaFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	GameUtil.SetActive(self._info, true)

	self._fmtMo.selectSeedMap = {}

	local activityCfg = OriginKayaConfig.instance:getActivityCfg(self._fmtMo.activityId)

	self._seedLimitCount = activityCfg.stageMaxUseSeed
	self._selectCount = 0

	self:_refreshView()
end

function OriginKayaFmtView:_refreshView()
	local floorCfg = OriginKayaConfig.instance:getFloorCfg(self._fmtMo.activityId, self._fmtMo.floorId)

	self._tableList:reloadData(floorCfg.needUseSeed)

	self._txtSeedCount.text = langPara("每关最多能使用%d个种子", self._seedLimitCount)
end

function OriginKayaFmtView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local selectGo = goutil.findChild(btnSelect, "selectGo")
	local usedGo = goutil.findChild(go, "used")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local imgChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)
	local seedCfg = OriginKayaConfig.instance:getSeedCfg(self._fmtMo.activityId, data)

	txtDesc.text = seedCfg.desc

	local seedInfo = OriginKayaModel.instance:getSeedInfo(self._fmtMo.activityId, self._fmtMo.floorId, data)
	local isUse = false

	if seedInfo then
		isUse = true

		imgChange:SetState(seedInfo.attr)
	else
		imgChange:SetState(0)
	end

	GameUtil.SetActive(usedGo, isUse)
	GameUtil.SetActive(btnSelect, not isUse)
	GameUtil.SetActive(selectGo, self._fmtMo.selectSeedMap[data] == true)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSeed(data)
	end)
end

function OriginKayaFmtView:_clearCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function OriginKayaFmtView:_onClickSeed(seedId)
	if self._fmtMo.selectSeedMap[seedId] == true then
		self._fmtMo.selectSeedMap[seedId] = nil
		self._selectCount = self._selectCount - 1
	else
		local seedCfg = OriginKayaConfig.instance:getSeedCfg(self._fmtMo.activityId, seedId)

		if seedCfg.type == 2 then
			if self._seedLimitCount <= self._selectCount then
				FloatWordMgr.instance:show(lang("已达同时选择数量上限"))
			else
				self._fmtMo.selectSeedMap[seedId] = true
				self._selectCount = self._selectCount + 1
			end
		else
			local activeTypeOne = 0

			for activeSeedId, result in pairs(self._fmtMo.selectSeedMap) do
				if result == true then
					local checkSeedCfg = OriginKayaConfig.instance:getSeedCfg(self._fmtMo.activityId, activeSeedId)

					if checkSeedCfg.type == 1 then
						activeTypeOne = activeSeedId

						break
					end
				end
			end

			if activeTypeOne == 0 then
				if self._seedLimitCount <= self._selectCount then
					FloatWordMgr.instance:show(lang("已达同时选择数量上限"))

					return
				else
					self._selectCount = self._selectCount + 1
					self._fmtMo.selectSeedMap[activeTypeOne] = nil
					self._fmtMo.selectSeedMap[seedId] = true
				end
			else
				self._fmtMo.selectSeedMap[activeTypeOne] = nil
				self._fmtMo.selectSeedMap[seedId] = true
			end
		end
	end

	self:_refreshView()
end

function OriginKayaFmtView:_onClickClose()
	GameUtil.SetActive(self._info, false)

	local newFormationCondition = 0
	local checkSeedCfg

	for activeSeedId, result in pairs(self._fmtMo.selectSeedMap) do
		if result == true then
			checkSeedCfg = OriginKayaConfig.instance:getSeedCfg(self._fmtMo.activityId, activeSeedId)

			if checkSeedCfg.type == 1 then
				newFormationCondition = checkSeedCfg.formConditionId

				break
			end
		end
	end

	self._fmtMo:setFormCondition(checknumber(newFormationCondition))
	self._fmtMo:clearAllFixedEffects()

	if checknumber(newFormationCondition) > 0 then
		local effectPath = "fx_ui_jinglinggezi/fx_ui_buzhen_07.prefab"

		for i, v in ipairs(checkSeedCfg.effectPos or {}) do
			self._fmtMo:setFixedEffect(v, effectPath)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
end

function OriginKayaFmtView:_onClickSeedInfo()
	GameUtil.SetActive(self._info, true)
end

return OriginKayaFmtView
