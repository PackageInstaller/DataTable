-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspaceinfiniteView.lua

module("logic.extensions.phantomspace.view.PhantomspaceinfiniteView", package.seeall)

local PhantomspaceinfiniteView = class("PhantomspaceinfiniteView", ViewComponent)

function PhantomspaceinfiniteView:ctor()
	PhantomspaceinfiniteView.super.ctor(self)
end

function PhantomspaceinfiniteView:unbindEvents()
	PhantomspaceinfiniteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnArrowLeft)
	GameUtil.rmClickHandler(self._btnArrowRight)
end

function PhantomspaceinfiniteView:bindEvents()
	PhantomspaceinfiniteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnArrowLeft, self._onClickBtnLeft, self)
	GameUtil.addClickHandler(self._btnArrowRight, self._onClickBtnRight, self)
end

function PhantomspaceinfiniteView:buildUI()
	PhantomspaceinfiniteView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("btnReset")
	self._txtTip = self:getTxt("tips_scr/scrView/Viewport/Content")
	self._btnArrowLeft = self:getGo("btnArrowLeft")
	self._btnArrowRight = self:getGo("btnArrowRight")
	self._txtPage = self:getTxt("page/txtPage")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PhantomspaceinfiniteView:onExit()
	PhantomspaceinfiniteView.super.onExit(self)
	self._scrollList:dispose()
end

function PhantomspaceinfiniteView:onEnter()
	PhantomspaceinfiniteView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PhantomSpaceGetEndlessInfoRes, self._onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_PhantomSpaceResetEndlessRes, self._onUpdate, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PhantomSpaceController.instance:getDefaultActivityId()
	end

	self._activityCfg = PhantomSpaceConfig.instance:getActivityCfgById(self._activityId)
	self._curPageNum = 1
	self._isFirstUpdate = true
	self._txtTip.text = PhantomSpaceConfig.instance:getCommonValue("INFINITE_RULE_TIP")

	PhantomSpaceController.instance:sendPM_PhantomSpaceGetEndlessInfoReq(self._activityId, 0, 0)
end

function PhantomspaceinfiniteView:_onGetInfoRes()
	if self._isFirstUpdate then
		self._endlessInfo = PhantomSpaceModel.instance:getEndlessInfo(self._activityId)

		local endlessCurStageId = self._endlessInfo.endlessCurStageId
		local pageNum, index = PhantomSpaceController.instance:getPageAndIndex(endlessCurStageId + 1)

		if (endlessCurStageId + 1) % PhantomSpaceController.endless_page_num then
			pageNum, index = PhantomSpaceController.instance:getPageAndIndex(endlessCurStageId)
		end

		local startIdx = math.max((pageNum - 1) * PhantomSpaceController.endless_page_num, 1)
		local endIdx = math.min(endlessCurStageId + 2, endlessCurStageId + PhantomSpaceController.endless_page_num)

		PhantomSpaceController.instance:sendPM_PhantomSpaceGetEndlessInfoReq(self._activityId, startIdx, endIdx)

		self._curPageNum = pageNum
		self._isFirstUpdate = false
	else
		self:_onUpdate()
	end
end

function PhantomspaceinfiniteView:_onUpdate()
	self._endlessInfo = PhantomSpaceModel.instance:getEndlessInfo(self._activityId)

	local endlessCurStageId = self._endlessInfo.endlessCurStageId
	local pageNum, index = PhantomSpaceController.instance:getPageAndIndex(endlessCurStageId + 1)

	if (endlessCurStageId + 1) % PhantomSpaceController.endless_page_num then
		pageNum, index = PhantomSpaceController.instance:getPageAndIndex(endlessCurStageId)
		self._curPageNum = pageNum
	end

	local curFightPageNum, curFightIndex = PhantomSpaceController.instance:getPageAndIndex(endlessCurStageId)

	self._txtPage.text = string.format("%d/%d", self._curPageNum, pageNum)

	local stageList = {}

	self._startIdx = (self._curPageNum - 1) * PhantomSpaceController.endless_page_num + 1
	self._endIdx = math.min(endlessCurStageId + 2, self._startIdx + PhantomSpaceController.endless_page_num - 1)

	for i = self._startIdx, self._endIdx do
		table.insert(stageList, i)
	end

	self._scrollList:reloadData(stageList)

	if self._curPageNum == pageNum then
		local curStageId = checknumber(self._endlessInfo.endlessCurStageId) - self._startIdx

		curStageId = math.max(0, math.min(curStageId + 1, checknumber(self._endlessInfo.endlessCurStageId)))

		self._scrollList:MoveCellToCenter(curStageId)
	end

	GameUtil.SetActive(self._btnArrowLeft, self._curPageNum ~= 1)
	GameUtil.SetActive(self._btnArrowRight, self._curPageNum ~= pageNum)
end

function PhantomspaceinfiniteView:_updateCell(view, cell, data)
	local fmt = goutil.findChild(cell, "formation/fmt")
	local pass = goutil.findChild(cell, "pass")
	local next = goutil.findChild(cell, "next")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local btnReset = goutil.findChild(cell, "btnReset")
	local txtStage = goutil.findChildTextComponent(cell, "title/txtStage")
	local endlessCurStageId = self._endlessInfo.endlessCurStageId
	local canFight = data == endlessCurStageId + 1
	local isNext = data == endlessCurStageId + 2

	if data == 1 then
		local formData = PhantomSpaceController.instance:getEndlessStageCpreepsForm(self._activityId)

		self:_setFmtByCfg(fmt, formData.cfg)
	elseif data == endlessCurStageId + 2 then
		self:_hideFmt(fmt)
	else
		local preFormInfo = PhantomSpaceModel.instance:getEndlessInfoBystageId(self._activityId, data - 1)

		if preFormInfo then
			self:_setFmt(fmt, preFormInfo)
		end
	end

	GameUtil.SetGray(btnReset, data == 1)

	txtStage.text = string.format("第%d关", data)

	GameUtil.SetActive(pass, not isNext and data <= endlessCurStageId)
	GameUtil.SetActive(next, isNext)
	GameUtil.SetActive(btnChallenge, not isNext and canFight)
	GameUtil.SetActive(btnReset, not isNext and canFight)
	GameUtil.addClickHandler(btnChallenge, function()
		if data == 1 then
			PhantomSpaceController.instance:openEndlessFirstFmtView(self._activityId, data, self._viewPresentor.viewName)
		else
			PhantomSpaceController.instance:openEndlessFmtView(self._activityId, data, self._viewPresentor.viewName)
		end
	end, self)
	GameUtil.addClickHandler(btnReset, function()
		if self._endlessInfo.endlessCurStageId == 0 then
			FloatWordMgr.instance:show("已为初始关卡，无需重置")

			return
		end

		local tipsContent = "重置后，需重新挑战上一关，以生成本关敌阵阵容。确定清空本关敌阵？"

		local function okFunc()
			PhantomSpaceController.instance:sendPM_PhantomSpaceResetEndlessReq(self._activityId, data - 1)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	end, self)
end

function PhantomspaceinfiniteView:_clearCell(cell)
	local fmt = goutil.findChild(cell, "formation/fmt")

	self:_clearFmt(fmt)
end

function PhantomspaceinfiniteView:_hideFmt(fmtView)
	for posId = 1, 9 do
		local go = fmtView.transform:GetChild(posId - 1)

		GameUtil.SetActive(go, false)
	end
end

function PhantomspaceinfiniteView:_setFmt(fmtView, data)
	local map = {}
	local form = data.form

	for i, v in ipairs(form.pos) do
		if v > 0 then
			local skinId = data.formPetFaceIdMap[v]

			if skinId then
				map[i] = skinId
			end
		end
	end

	for posId = 1, 9 do
		local skinId = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if skinId then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, skinId)
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function PhantomspaceinfiniteView:_setFmtByCfg(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function PhantomspaceinfiniteView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function PhantomspaceinfiniteView:_onClickBtnReset()
	if self._endlessInfo.endlessCurStageId == 0 then
		FloatWordMgr.instance:show("已为初始关卡，无需重置")

		return
	end

	local tipStr = "重置后，将清空所有敌阵，需从第1关开始重新挑战。确定重置所有敌阵？"

	local function okFunc()
		PhantomSpaceController.instance:sendPM_PhantomSpaceResetEndlessReq(self._activityId, 0)
	end

	TipsFacade.instance:openPopupWindow("提示", tipStr, okFunc, nil, "确定", "取消")
end

function PhantomspaceinfiniteView:_onClickBtnLeft()
	self._curPageNum = self._curPageNum - 1

	local curPageFirstIdx = (self._curPageNum - 1) * PhantomSpaceController.endless_page_num + 1
	local curPageEndlessInfo = PhantomSpaceModel.instance:getEndlessInfoBystageId(self._activityId, curPageFirstIdx)

	if not curPageEndlessInfo then
		local endIdx = curPageFirstIdx + PhantomSpaceController.endless_page_num - 1

		PhantomSpaceController.instance:sendPM_PhantomSpaceGetEndlessInfoReq(self._activityId, curPageFirstIdx, endIdx)

		return
	end

	self:_onUpdate()
end

function PhantomspaceinfiniteView:_onClickBtnRight()
	self._curPageNum = self._curPageNum + 1

	local curPageFirstIdx = (self._curPageNum - 1) * PhantomSpaceController.endless_page_num + 1
	local curPageEndlessInfo = PhantomSpaceModel.instance:getEndlessInfoBystageId(self._activityId, curPageFirstIdx)

	if not curPageEndlessInfo then
		local endIdx = curPageFirstIdx + PhantomSpaceController.endless_page_num - 1

		PhantomSpaceController.instance:sendPM_PhantomSpaceGetEndlessInfoReq(self._activityId, curPageFirstIdx, endIdx)

		return
	end

	self:_onUpdate()
end

return PhantomspaceinfiniteView
