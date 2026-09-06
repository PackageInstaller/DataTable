-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeLifeView.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeLifeView", package.seeall)

local FanRuiChallengeLifeView = class("FanRuiChallengeLifeView", ViewComponent)

function FanRuiChallengeLifeView:buildUI()
	FanRuiChallengeLifeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("stageInfo/btnChallenge")
	self._itemList = {}

	for i = 1, 3 do
		local cell = {}
		local path = "btnStage" .. i

		cell.pass = self:getGo(path .. "/pass")
		cell.select = self:getGo(path .. "/select")
		cell.headIcon = self:getGo(path .. "/headIcon")

		table.insert(self._itemList, cell)
	end

	local stageInfo = self:getGo("stageInfo")

	self._txtTitle = goutil.findChildTextComponent(stageInfo, "txtTitle")
	self._txtDesc1 = goutil.findChildTextComponent(stageInfo, "txtDesc1")
	self._txtDesc2 = goutil.findChildTextComponent(stageInfo, "txtDesc2")
	self.cellGo = goutil.findChild(stageInfo, "tablecell")
	self.scrollerGo1 = goutil.findChild(stageInfo, "tableview1")
	self._scrollList1 = ScrollerList.create(self.scrollerGo1, self.cellGo, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self._clearCell1, self))
	self.scrollerGo2 = goutil.findChild(stageInfo, "tableview2")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
end

function FanRuiChallengeLifeView:bindEvents()
	FanRuiChallengeLifeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function FanRuiChallengeLifeView:unbindEvents()
	FanRuiChallengeLifeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function FanRuiChallengeLifeView:onEnter()
	FanRuiChallengeLifeView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._cfgStages = FanRuiChallengeConfig.instance:getLifeClgStageCfgList(self._activityId)
	self._passNum = FanRuiChallengeModel.instance:getLifePassProgress(self._activityId)
	self._maxNum = #self._cfgStages
	self._curStageIndex = Mathf.Clamp(self._passNum + 1, 1, self._maxNum)
	self._isPassAll = self._passNum >= self._maxNum

	self:_updateBtnsInfo()
	self:_updateCurStageInfo()
end

function FanRuiChallengeLifeView:onExit()
	FanRuiChallengeLifeView.super.onExit(self)
	self:_clearImages()
end

function FanRuiChallengeLifeView:_onClickChallenge()
	if self._isPassAll then
		FloatWordMgr.instance:show("已通关所有关卡")
	else
		FanRuiChallengeController.instance:openLifeMissionView(self._activityId, self._curStageIndex, self._viewPresentor.viewName)
	end
end

function FanRuiChallengeLifeView:_updateCell1(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, node)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function FanRuiChallengeLifeView:_clearCell1(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function FanRuiChallengeLifeView:_updateCell2(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function FanRuiChallengeLifeView:_clearCell2(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function FanRuiChallengeLifeView:_updateBtnsInfo()
	for i = 1, 3 do
		local item = self._itemList[i]

		if item then
			goutil.setActive(item.select, self._curStageIndex == i)
			goutil.setActive(item.pass, i <= self._passNum)

			local cfg = FanRuiChallengeConfig.instance:getLifeClgStageCfg(self._activityId, i)

			if cfg then
				local cfgCreeps = FanRuiChallengeConfig.instance:getCreepsCfgs(cfg.creepsMasterId)

				if cfgCreeps[1] then
					MaterialMgr.setIcon(item.headIcon, MatType.Pet, cfgCreeps[1].raceId)
				end
			end
		end
	end
end

function FanRuiChallengeLifeView:_clearImages()
	for i, v in ipairs(self._itemList) do
		MaterialMgr.clearIcon(v.headIcon)
	end
end

function FanRuiChallengeLifeView:_updateCurStageInfo()
	local curIndex = self._curStageIndex

	self._txtTitle.text = string.format("生命之源•第%d关", curIndex)

	local cfg = FanRuiChallengeConfig.instance:getLifeClgStageCfg(self._activityId, curIndex)

	if cfg then
		if not string.nilorempty(cfg.title) then
			self._txtTitle.text = cfg.title
		end

		self._txtDesc1.text = cfg.buffDesc

		local cfgMonster = FanRuiChallengeConfig.instance:getMonsterCfg(cfg.creepsMasterId)

		if cfgMonster then
			self._txtDesc2.text = cfgMonster.WinDesc
		end

		local cfgCreeps = FanRuiChallengeConfig.instance:getCreepsCfgs(cfg.creepsMasterId)

		self._scrollList1:reloadData(cfgCreeps)

		local arr = MaterialMgr.changeItemStrArr(cfg.passStagePrize)

		self._scrollList2:reloadData(arr)
	end
end

return FanRuiChallengeLifeView
