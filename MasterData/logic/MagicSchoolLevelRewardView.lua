-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolLevelRewardView.lua

module("logic.extensions.magicschool.view.MagicSchoolLevelRewardView", package.seeall)

local MagicSchoolLevelRewardView = class("MagicSchoolLevelRewardView", ViewComponent)

function MagicSchoolLevelRewardView:ctor()
	MagicSchoolLevelRewardView.super.ctor(self)
end

function MagicSchoolLevelRewardView:unbindEvents()
	MagicSchoolLevelRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGetExp)
end

function MagicSchoolLevelRewardView:bindEvents()
	MagicSchoolLevelRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGetExp, self._onClickGetExp, self)
end

function MagicSchoolLevelRewardView:buildUI()
	MagicSchoolLevelRewardView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnGetExp = self:getGo("btnGetExp")
	self._icon = self:getGo("total/icon")
	self._txtNum = self:getTxt("total/txtNum")
	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._txtBuff = self:getTxt("buffTip/scrView/Viewport/txtBuff")
	self._tableview = self:getGo("scorollProgress/tableview")
	self._viewport = self:getGo("scorollProgress/tableview/viewport")
	self._tablecell = self:getGo("scorollProgress/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._progressSlider = self:getSlider("scorollProgress/tableview/viewport/content/progressSlider")
end

function MagicSchoolLevelRewardView:onExit()
	MagicSchoolLevelRewardView.super.onExit(self)
	MaterialMgr.clearIcon(self._icon)
	self._scrollList:dispose()

	for cellGo, scrollList in pairs(self._scrollListMap) do
		scrollList:dispose()

		self._scrollListMap[cellGo] = nil
	end
end

function MagicSchoolLevelRewardView:onEnter()
	MagicSchoolLevelRewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolGainLevelPrizeRes, self._onGainLevelPrizeRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	self._actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)

	MaterialMgr.setIcon(self._icon, MatType.ACTIVITY_ITEM, self._actCfg.progressActivityItemId, nil, nil)
	MagicSchoolController.instance:sendPM_MagicSchoolGetInfoReq(self._activityId)
end

function MagicSchoolLevelRewardView:_onUpdate()
	self._scrollListMap = {}
	self._info = MagicSchoolModel.instance:getInfo(self._activityId)
	self._campId = self._info.campId
	self._levelPrizeCfgs = MagicSchoolConfig.instance:getLevelPrizeCfgs(self._activityId, self._campId)
	self._curScore = checknumber(self._info.score)

	local buffDescStr = MagicSchoolController.instance:getBuffStr(self._activityId, self._campId)
	local scoreList = {}

	for i, v in ipairs(self._levelPrizeCfgs) do
		table.insert(scoreList, v.progress)
	end

	self._txtNum.text = self._curScore
	self._txtBuff.text = buffDescStr

	self._scrollList:reloadData(self._levelPrizeCfgs)
	self._scrollList:updateUnderSlider(self._progressSlider, self._curScore, scoreList)

	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end
end

function MagicSchoolLevelRewardView:_updateCell(view, cell, data)
	local bg = goutil.findChild(cell, "bg")
	local imgCamp = goutil.findChild(cell, "imgCamp")
	local btnGet = goutil.findChild(cell, "btnGet")
	local imgCampChangeComp = imgCamp:GetComponent("UIImageSpriteChange")
	local spriteChangeComp = goutil.findChild(cell, "imgProgress"):GetComponent("UIImageSpriteChange")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(cell, "tips/txtTitle")
	local tableviewReward = goutil.findChild(cell, "tableviewReward")
	local tablecell = goutil.findChild(cell, "tableviewReward/tablecell")

	if self._scrollListMap[cell] == nil then
		self._scrollListMap[cell] = ScrollerList.create(tableviewReward, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	end

	local scrollList = self._scrollListMap[cell]
	local score = checknumber(self._info.score)
	local hasGetProgress = score >= data.progress
	local spriteChangeIdx = hasGetProgress and 1 or 0
	local bgPath = string.format("ui/bigbg/magicschool/%s.png", data.bgName)
	local curLv = MagicSchoolController.instance:getPlayerLevel(self._activityId, self._campId)
	local hasGeted = table.indexof(self._info.levelPrizeIds, data.level)
	local catchCurLevel = curLv >= data.level
	local hasFinishBgName = string.nilorempty(data.finishBgName)
	local prize = data.prize
	local prizeArr = string.split(prize, "#")
	local rewardData = {}

	for i, v in ipairs(prizeArr) do
		local reward = {}

		reward.prize = v
		reward.cfg = data

		table.insert(rewardData, reward)
	end

	txtScore.text = data.progress
	txtDesc.text = data.desc
	txtTitle.text = data.title

	spriteChangeComp:SetState(spriteChangeIdx)
	imgCampChangeComp:SetState(self._campId - 1)
	uGuiUtil.setSpriteToImage(bg, uGuiUtil.SpriteType.BigBg, (catchCurLevel and not hasFinishBgName or nil) and string.format("ui/bigbg/magicschool/%s.png", data.finishBgName))
	GameUtil.setAnchoredPos(txtTitle.gameObject, data.titlePos[1], data.titlePos[2])
	GameUtil.SetActive(imgCamp, catchCurLevel)
	GameUtil.SetActive(btnGet, catchCurLevel and not hasGeted)
	scrollList:reloadData(rewardData)
	scrollList:setCenterMode(true)
	GameUtil.addClickHandler(btnGet, function()
		MagicSchoolController.instance:sendPM_MagicSchoolGainLevelPrizeReq(self._activityId, data.level)
	end, self)
end

function MagicSchoolLevelRewardView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local bg = goutil.findChild(cell, "bg")
	local btnGet = goutil.findChild(cell, "btnGet")
	local scrollList = self._scrollListMap[cell]

	if scrollList then
		scrollList:dispose()

		self._scrollListMap[cell] = nil
	end

	MaterialMgr.resetAll(item)
	uGuiUtil.clearImage(bg)
	GameUtil.rmClickHandler(btnGet)
end

function MagicSchoolLevelRewardView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local eff = goutil.findChild(cell, "eff")
	local prizeStr = data.prize
	local canGet = self._curScore >= data.cfg.progress
	local hasGeted = table.indexof(self._info.levelPrizeIds, data.cfg.level)

	MaterialMgr.setCellByCfg(prizeStr, item)
	GameUtil.SetActive(geted, canGet and hasGeted)
	self:stopViewEffectUniGo(eff)

	if canGet and not hasGeted then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", eff, self._viewport.transform, true, nil, nil)
	end
end

function MagicSchoolLevelRewardView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function MagicSchoolLevelRewardView:_onClickGetExp()
	local progressActivityItemId = self._actCfg.progressActivityItemId
	local matStr = string.format("%d:%d", MatType.ACTIVITY_ITEM, progressActivityItemId)

	TipsFacade.instance:openItemSourceView(matStr)
end

function MagicSchoolLevelRewardView:_onGainLevelPrizeRes()
	self:_onUpdate()
end

return MagicSchoolLevelRewardView
