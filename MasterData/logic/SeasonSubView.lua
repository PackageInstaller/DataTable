-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/reward/SeasonSubView.lua

module("logic.extensions.scuffle.view.reward.SeasonSubView", package.seeall)

local SeasonSubView = class("SeasonSubView", TableViewComponent)

function SeasonSubView:buildUI(parentGo)
	self.mainGO = parentGo

	SeasonSubView.super.buildUI(self)

	self._scroll = self:getScrollRect("tableview")
end

function SeasonSubView:bindEvents()
	SeasonSubView.super.bindEvents(self)
end

function SeasonSubView:unbindEvents()
	SeasonSubView.super.unbindEvents(self)
end

function SeasonSubView:onEnter()
	SeasonSubView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SF_AchievePrizeInfoRes, self._onAchievePrizeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SF_GainAchievePrizeRes, self._onGainAchievePrizeRes, self)

	self._isFirst = true
	self._curSeasonId = ScuffleController.instance:getCurSeasonId()

	ScuffleAgent.instance:sendSF_AchievePrizeInfoReq()
end

function SeasonSubView:onExit()
	SeasonSubView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_AchievePrizeInfoRes, self._onAchievePrizeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_GainAchievePrizeRes, self._onGainAchievePrizeRes, self)
end

function SeasonSubView:show()
	self.mainGO:SetActive(true)
	self:_resetTopPos()
	self:_updateLevelPrizeList()
end

function SeasonSubView:hide()
	self.mainGO:SetActive(false)
end

function SeasonSubView:_onAchievePrizeInfoRes()
	if self._isFirst then
		self._isFirst = false

		self:_updateLevelPrizeList()
	end
end

function SeasonSubView:_onGainAchievePrizeRes(id)
	self:_updateChildItem(id)
end

function SeasonSubView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function SeasonSubView:_updateCell(view, cell, data)
	local levelIcon = goutil.findChild(cell, "levelIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local goContent = goutil.findChild(cell, "tableview/viewport/content")
	local btnGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGet")
	local passed = goutil.findChild(cell, "passed")
	local scroll = Framework.ScrollRectAdapter.GetFrom(cell.gameObject, "tableview")

	scroll.scrollRect.horizontalNormalizedPosition = 0

	local cfg = ScuffleConfig.instance:getLevelCfg(data.level)

	if cfg then
		uGuiUtil.setSpriteToImage(levelIcon, uGuiUtil.SpriteType.BigBg, string.format(ScuffleModel.LevelPath, cfg.icon))

		txtLevel.text = string.format("%d积分及以上", cfg.baseScore)
	end

	txtName.text = data.bigLevelName

	local arrProxy = MaterialMgr.setCellListByCfg(data.levelPrize, goContent)

	for i, v in ipairs(arrProxy) do
		Framework.TransformUtil.SetLocalScale(v.view.transform, 0.7, 0.7, 0.7)
	end

	local isPassed = ScuffleModel.instance:isAchievePrizeGet(data.level)
	local isScoreEnough = false

	if cfg then
		isScoreEnough = ScuffleModel.instance:getMaxScore() >= cfg.baseScore
	end

	goutil.setActive(passed, isPassed)
	goutil.setActive(btnGet.gameObject, not isPassed)

	btnGet.btn.interactable = isScoreEnough

	local id = data.level
	local name = data.bigLevelName

	btnGet:AddClickListener(function()
		if isScoreEnough then
			ScuffleAgent.instance:sendSF_GainAchievePrizeReq(id)
		else
			FloatWordMgr.instance:show(string.format("还未达到 %s", name))
		end
	end)
end

function SeasonSubView:_clearTableview(cell)
	local levelIcon = Framework.ImageBigBG.GetFrom(cell.gameObject, "levelIcon")
	local goContent = goutil.findChild(cell, "tableview/viewport/content")
	local btnGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGet")

	levelIcon:ClearImage()
	MaterialMgr.resetAll(goContent)
	btnGet:RemoveClickListener()
end

function SeasonSubView:_updateLevelPrizeList()
	local cfgs = ScuffleConfig.instance:getLevelPrizeCfgs(self._curSeasonId)

	self:updateListData(cfgs)
end

function SeasonSubView:_resetTopPos()
	self._scroll.scrollRect.verticalNormalizedPosition = 1
end

function SeasonSubView:_updateChildItem(id)
	for i, v in ipairs(self._curViewDatas) do
		if v.level == id then
			self._tableview:UpdateCellAtIndex(i - 1)

			break
		end
	end
end

return SeasonSubView
