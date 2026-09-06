-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqimainView.lua

module("logic.extensions.doushouqi.view.DoushouqimainView", package.seeall)

local DoushouqimainView = class("DoushouqimainView", ViewComponent)

DoushouqimainView.KeyClickRule = "DoushouqimainView_KeyClickRule"

function DoushouqimainView:ctor()
	DoushouqimainView.super.ctor(self)
end

function DoushouqimainView:unbindEvents()
	DoushouqimainView.super.unbindEvents(self)
	self._btnWeihuTutorial:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnWeihu:RemoveClickListener()
	self._btnDoushouqi:RemoveClickListener()
	self._btnDoushouqiTutorial:RemoveClickListener()
	self._btnLook:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnImgRule:RemoveClickListener()
end

function DoushouqimainView:bindEvents()
	DoushouqimainView.super.bindEvents(self)
	self._btnWeihuTutorial:AddClickListener(self._onClickbtnWeihuTutorial, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnWeihu:AddClickListener(self._onClickbtnWeihu, self)
	self._btnDoushouqi:AddClickListener(self._onClickbtnDoushouqi, self)
	self._btnDoushouqiTutorial:AddClickListener(self._onClickbtnDoushouqiTutorial, self)
	self._btnLook:AddClickListener(self._onClickbtnLook, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btnTask:AddClickListener(self._onClickbtnTask, self)
	self._btnImgRule:AddClickListener(self._onClickbtnImgRule, self)
end

function DoushouqimainView:buildUI()
	DoushouqimainView.super.buildUI(self)

	self._btnWeihuTutorial = self:getBtn("btnWeihuTutorial")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnWeihu = self:getBtn("btnWeihu")
	self._btnDoushouqi = self:getBtn("btnDoushouqi")
	self._btnDoushouqiTutorial = self:getBtn("btnDoushouqiTutorial")
	self._btnLook = self:getBtn("skill/btnLook")
	self._txtTime = self:getTxt("time/txt")
	self._goSkillIcon = self:getGo("skill/skillIcon")
	self._txtSkillName = self:getTxt("skill/skillName")
	self._btnRank = self:getBtn("btnRank")
	self._btnReward = self:getBtn("btnReward")
	self._btnTask = self:getBtn("btnTask")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("empty")
	self._conGo = self:getGo("con")
	self._rewardRedPointGo = self:getGo("btnReward/redPoint")
	self._taskRedPointGo = self:getGo("btnTask/redPoint")
	self._btnImgRule = self:getBtn("btnImgRule")
	self._imgRuleRedPointGo = self:getGo("btnImgRule/redPoint")
	self._txtTimeLimit = self:getTxt("txtTimeLimit")
	self._txtDoushouTime = self:getTxt("btnDoushouqi/txtTime")
	self._txtWeihuTime = self:getTxt("btnWeihu/txtTime")
end

function DoushouqimainView:onExit()
	DoushouqimainView.super.onExit(self)
	uGuiUtil.clearImage(self._goSkillIcon)
	self._scrollerList:dispose()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)

	RedPointController.instance:unregRedPoint(self._rewardRedPointGo)
	RedPointController.instance:unregRedPoint(self._taskRedPointGo)
	RedPointController.instance:unregRedPoint(self._imgRuleRedPointGo)
end

function DoushouqimainView:onEnter()
	DoushouqimainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessInfoRes, self._onBeastFightingChessInfoRes, self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessSelectSkillRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessRecordRes, self._onBeastFightingChessRecordRes, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self:_setActTime()
	self:_playEffect()
	self:_setRole()
	BeastFightingChessAgent.instance:sendBeastFightingChessRecordReq(self._activityId)
	BeastFightingChessAgent.instance:sendBeastFightingChessInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._rewardRedPointGo, 628)
	RedPointController.instance:regRedPoint(self._taskRedPointGo, 625)
	RedPointController.instance:regRedPoint(self._imgRuleRedPointGo, -442)
	self:_setOpenTime()
	self:_setMathchLeftTime()
end

function DoushouqimainView:_updateUI()
	self:_updateSkill()
end

function DoushouqimainView:_onClickbtnWeihuTutorial()
	DoushouqiTigerGameController.instance:startGame(self._activityId, true)
end

function DoushouqimainView:_onClickbtnClose()
	self:close()
end

function DoushouqimainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("doushouqimainrule")
end

function DoushouqimainView:_onClickbtnWeihu()
	if not self:_checkCanFight(DoushouqiController.ChessType.Weihuqi) then
		return
	end

	local typeInfo = DoushouqiModel.instance:getTypeInfo(DoushouqiController.ChessType.Weihuqi)
	local isClicked = GameUtil.getUserData(DoushouqimainView.KeyClickRule) or 0

	if isClicked <= 0 then
		self:_onClickbtnTip()
		GameUtil.saveUserData(DoushouqimainView.KeyClickRule, 1)

		return
	end

	if DoushouqiController.instance:isWenhuqiGuiding() then
		self:_onClickbtnWeihuTutorial()

		return
	end

	UIStateManager.instance:push(ViewName.DoushouqimatchView, self._activityId, DoushouqiController.ChessType.Weihuqi)
end

function DoushouqimainView:_onClickbtnImgRule()
	local infos = DoushouqiConfig.instance:getImgRuleInfos()

	TipsFacade.instance:openImageRuleView(infos, "游戏规则")
	DoushouqiController.instance:saveImgRuleRedpoint(self._activityId)
end

function DoushouqimainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.DoushouqirankView, self._activityId)
end

function DoushouqimainView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.DoushouqirewardView, self._activityId)
end

function DoushouqimainView:_onClickbtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function DoushouqimainView:_onClickbtnDoushouqi()
	if not self:_checkCanFight(DoushouqiController.ChessType.Doushouqi) then
		return
	end

	local isClicked = GameUtil.getUserData(DoushouqimainView.KeyClickRule) or 0

	if isClicked <= 0 then
		self:_onClickbtnTip()
		GameUtil.saveUserData(DoushouqimainView.KeyClickRule, 1)

		return
	end

	if DoushouqiController.instance:isDoushouqiGuiding() then
		self:_onClickbtnDoushouqiTutorial()

		return
	end

	UIStateManager.instance:push(ViewName.DoushouqimatchView, self._activityId, DoushouqiController.ChessType.Doushouqi)
end

function DoushouqimainView:_onClickbtnDoushouqiTutorial()
	DoushouqiGameController.instance:enterTutorial(self._activityId)
end

function DoushouqimainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BeastFightingChess)
	end
end

function DoushouqimainView:_onBeastFightingChessInfoRes()
	self:_setMathchLeftTime()
end

function DoushouqimainView:_onClickbtnLook()
	UIStateManager.instance:push(ViewName.DoushouqiselectskillView, self._activityId)
end

function DoushouqimainView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.BeastFightingChess, self._activityId)
end

function DoushouqimainView:_updateSkill()
	local skillId = DoushouqiModel.instance:getMySkillId()
	local skillCfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, skillId)
	local spriteName = string.format("%s.png", skillCfg.iconPath)

	uGuiUtil.setSpriteToImage(self._goSkillIcon, uGuiUtil.SpriteType.BigBg, spriteName)

	self._txtSkillName.text = skillCfg.name
end

function DoushouqimainView:_onBeastFightingChessRecordRes(records)
	self:_updateRecord(records)
end

function DoushouqimainView:_updateRecord(records)
	records = records or {}

	local recordsSort = {}

	table.insertto(recordsSort, records)
	table.sort(recordsSort, function(a, b)
		return checknumber(a.recordTime) > checknumber(b.recordTime)
	end)
	self._scrollerList:reloadData(recordsSort)
	goutil.setActive(self._emptyGo, #recordsSort <= 0)
end

function DoushouqimainView:_updateCell(view, cell, data, tag)
	local goHead = goutil.findChild(cell.gameObject, "player1/head")
	local imgChangeImgState = goutil.findChild(cell.gameObject, "imgState"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtType = goutil.findChildTextComponent(cell.gameObject, "txtType")
	local player1 = goutil.findChild(cell.gameObject, "player1")
	local player2 = goutil.findChild(cell.gameObject, "player2")

	self:_updatePlayer(true, player1)
	self:_updatePlayer(false, player2, data.opHeadInfo, data.opAreaName)
	imgChangeImgState:SetState(data.result == 1 and 0 or data.result == 2 and 1 or 2)

	txtType.text = DoushouqiConfig.instance:getChessTypeName(self._activityId, data.typeId)
end

function DoushouqimainView:_updatePlayer(isMe, root, headInfo, areaName)
	local txtArea = goutil.findChildTextComponent(root.gameObject, "txtArea")
	local goHead = goutil.findChild(root.gameObject, "head")
	local txtName = goutil.findChildTextComponent(root.gameObject, "txtName")

	HeadItemController.instance:resetHeadCell(goHead)

	if isMe then
		HeadItemController.instance:setMyHeadCell(goHead)

		txtArea.text = RoleModel.instance:getAreaName()
		txtName.text = RoleModel.instance:getUserName()
	else
		HeadItemController.instance:setHeadCellByInfo(goHead, headInfo)

		txtArea.text = areaName
		txtName.text = headInfo.userName
	end
end

function DoushouqimainView:_clearCell(cell)
	return
end

function DoushouqimainView:_playEffect()
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_fw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function DoushouqimainView:_setRole()
	local path = GameUrl.getLihuiSpineUIUrl("99999_aoqinan_lihui_duihua")

	self._roleObj = RoleObjectPool.instance:addSpineToParent(self._roleObj, path, self._conGo)
end

function DoushouqimainView:_setOpenTime()
	local actCfg = DoushouqiConfig.instance:getActivityCfg(self._activityId)

	if string.nilorempty(actCfg.openTime) then
		self._txtTimeLimit.text = ""

		return
	end

	local arr = string.split(actCfg.openTime, "-")
	local stime = checknumber(arr[1])
	local etime = checknumber(arr[2])

	self._txtTimeLimit.text = string.format("开放时间:%02d:00-%02d:00", stime, etime)
end

function DoushouqimainView:_isInOpenTime()
	local actCfg = DoushouqiConfig.instance:getActivityCfg(self._activityId)

	if string.nilorempty(actCfg.openTime) then
		return true
	end

	local arr = string.split(actCfg.openTime, "-")
	local stime = checknumber(arr[1])
	local etime = checknumber(arr[2])
	local date = ServerTime.nowDate()

	if stime > date.hour or etime < date.hour then
		return false
	end

	return true
end

function DoushouqimainView:_checkCanFight(chessType)
	if not self:_isInOpenTime() then
		FloatWordMgr.instance:show("不在开放时间内")

		return
	end

	local typeInfo = DoushouqiModel.instance:getTypeInfo(chessType)

	if not typeInfo then
		return false
	end

	local typeCfg = DoushouqiConfig.instance:getChessTypeCfg(self._activityId, chessType)

	if typeInfo.dailyFightTimes >= typeCfg.dailyTimes then
		FloatWordMgr.instance:show("今日匹配次数已达上限，次日5:00重置后再来吧")

		return false
	end

	if DoushouqiController.instance:isBan(self._activityId, chessType) then
		local banTip = DoushouqiController.instance:getBanTip(self._activityId, chessType)

		FloatWordMgr.instance:show(banTip)

		return false
	end

	return true
end

function DoushouqimainView:_setMathchLeftTime()
	self._txtDoushouTime.text = self:_getLeftTimeStr(DoushouqiController.ChessType.Doushouqi)
	self._txtWeihuTime.text = self:_getLeftTimeStr(DoushouqiController.ChessType.Weihuqi)
end

function DoushouqimainView:_getLeftTimeStr(chessType)
	local info = DoushouqiModel.instance:getTypeInfo(chessType)

	if info then
		local typeCfg = DoushouqiConfig.instance:getChessTypeCfg(self._activityId, chessType)

		return string.format("次数：%s/%s", typeCfg.dailyTimes - info.dailyFightTimes, typeCfg.dailyTimes)
	end

	return ""
end

return DoushouqimainView
