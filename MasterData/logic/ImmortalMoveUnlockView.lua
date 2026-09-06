-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveUnlockView.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveUnlockView", package.seeall)

local ImmortalMoveUnlockView = class("ImmortalMoveUnlockView", ViewComponent)

function ImmortalMoveUnlockView:ctor()
	ImmortalMoveUnlockView.super.ctor(self)
end

function ImmortalMoveUnlockView:unbindEvents()
	ImmortalMoveUnlockView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStory)
end

function ImmortalMoveUnlockView:bindEvents()
	ImmortalMoveUnlockView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStory, self._onClickBtnStory, self)
end

function ImmortalMoveUnlockView:buildUI()
	ImmortalMoveUnlockView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnStory = self:getGo("btnStory")
	self._con = self:getGo("con")
	self._itemCell = self:getGo("itemCell")
	self._notecell = self:getGo("notecell")

	local goTableviewInfo = self:getGo("info/tableview")
	local gotablecellInfo = self:getGo("info/tableview/tablecell")

	self._tableviewInfo = ScrollerList.create(goTableviewInfo, gotablecellInfo, GameUtil.handler(self._updatCellInfo, self), GameUtil.handler(self._clearCellInfo, self))
end

function ImmortalMoveUnlockView:onExit()
	ImmortalMoveUnlockView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._tableviewInfo:dispose()
	table.clear(self._subTab1s)
	table.clear(self._subTab2s)
end

function ImmortalMoveUnlockView:onEnter()
	ImmortalMoveUnlockView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 484001
	end

	self._subTab1s = {}
	self._subTab2s = {}

	self.addGEvent(self, GlobalNotify.ImmortalMovementGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.ImmortalMovementUnlockScore, self._handleUnlock, self)
	self:_updateUIByCfg()
	ImmortalMovementController.instance:getInfo(self._activityId)
end

function ImmortalMoveUnlockView:_updateUIByCfg()
	self._actCfg = ImmortalMovementConfig.instance:getActCfgById(self._activityId)
	self._curSkinId = self._actCfg.skinId
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
	self._scoreCfgs = ImmortalMovementConfig.instance:getScoreCfgs(self._activityId)
	self._storyCfgs = ImmortalMovementConfig.instance:getStoryCfgs(self._activityId) or {}
end

function ImmortalMoveUnlockView:_updateUIByInfo()
	local info = ImmortalMovementModel.instance:getBaseInfo(self._activityId)

	self._hasUnlockScore = {}
	self._hasGainNote = {}

	if info then
		self._hasUnlockScore = info.hasUnlockScore or {}
		self._hasGainNote = info.hasGainNote or {}
	end

	self._tableviewInfo:reloadData(self._scoreCfgs)
end

function ImmortalMoveUnlockView:_handleUnlock()
	self:_updateUIByInfo()

	local sortId = #self._hasUnlockScore

	if sortId > 0 then
		local cfg = self._storyCfgs[sortId]

		if cfg and cfg.storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.storyId, StoryModel.StoryType.SCCopy)
		end
	end
end

function ImmortalMoveUnlockView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function ImmortalMoveUnlockView:_updatCellInfo(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")

	txtTitle.text = data.title

	local scoreId = data.scoreId
	local prizeStr = data.prize

	if not data.requiredNotes then
		local prizeStrArr = string.split(prizeStr, "#") or {}
		local itemDataList = {}

		for i, itemStr in ipairs(prizeStrArr) do
			table.insert(itemDataList, {
				scoreId = scoreId,
				itemStr = itemStr
			})
		end

		local noteDataList = {}

		for i, note in ipairs(data.requiredNotes) do
			table.insert(noteDataList, {
				scoreId = scoreId,
				note = note
			})
		end

		local subTab1 = self._subTab1s[cell.gameObject]

		if not subTab1 then
			local notetableview = goutil.findChild(cell.gameObject, "notetableview")

			subTab1 = ScrollerList.create(notetableview, self._notecell, GameUtil.handler(self._updatCellNote, self), GameUtil.handler(self._clearCellNote, self))

			subTab1:dragNotifyParent()

			self._subTab1s[cell.gameObject] = subTab1
		end

		subTab1:reloadData(noteDataList)
		subTab1:MoveCellToBegin(0)

		local subTab2 = self._subTab2s[cell.gameObject]

		if not subTab2 then
			local itemtableview = goutil.findChild(cell.gameObject, "itemtableview")

			subTab2 = ScrollerList.create(itemtableview, self._itemCell, GameUtil.handler(self._updatCellItem, self), GameUtil.handler(self._clearCellItem, self))

			subTab2:dragNotifyParent()
			subTab2:setCenterMode(true)

			self._subTab2s[cell.gameObject] = subTab2
		end

		subTab2:reloadData(itemDataList)
	end
end

function ImmortalMoveUnlockView:_clearCellInfo(cell)
	local subTab1 = self._subTab1s[cell.gameObject]

	if subTab1 then
		subTab1:dispose()
	end

	local subTab2 = self._subTab2s[cell.gameObject]

	if subTab2 then
		subTab2:dispose()
	end
end

function ImmortalMoveUnlockView:_updatCellItem(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")
	local gain = goutil.findChild(cell.gameObject, "gain")
	local scoreId = data.scoreId
	local itemStr = data.itemStr
	local isGain = table.keyof(self._hasUnlockScore, scoreId) ~= nil

	goutil.setActive(gain, isGain)
	MaterialMgr.setCellByCfg(itemStr, item)
end

function ImmortalMoveUnlockView:_clearCellItem(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function ImmortalMoveUnlockView:_updatCellNote(view, cell, data)
	local scoreId = data.scoreId
	local note = data.note
	local cover = goutil.findChild(cell.gameObject, "cover")
	local mark = goutil.findChild(cell.gameObject, "mark")
	local isGain = table.keyof(self._hasGainNote, note) ~= nil

	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onClickNote, self, scoreId))

	local isUnlock = table.keyof(self._hasUnlockScore, scoreId)

	goutil.setActive(cover, not isGain)
	goutil.setActive(mark, isGain and self:_isMatchUnlock(scoreId) and not isUnlock)

	local noteChange = goutil.findChildComponent(cell.gameObject, "img", "UIImageSpriteChange")
	local coverChange = goutil.findChildComponent(cell.gameObject, "cover", "UIImageSpriteChange")
	local noteId = checknumber(note) % 4

	if noteId == 0 then
		noteId = 4
	end

	noteChange:SetState(noteId - 1)
	coverChange:SetState(noteId - 1)
end

function ImmortalMoveUnlockView:_clearCellNote(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function ImmortalMoveUnlockView:_isMatchUnlock(sortId)
	if self._scoreCfgs then
		if not self._scoreCfgs then
			return false
		end

		if not self._scoreCfgs.requiredNotes then
			local requiredNotes = {}

			for _, note in ipairs(requiredNotes) do
				if not table.keyof(self._hasGainNote, note) then
					return false
				end
			end

			return true
		end
	end
end

function ImmortalMoveUnlockView:_onClickNote(sortId)
	if table.keyof(self._hasUnlockScore, sortId) then
		TipsFacade.instance:openCommonTips("已谱写")

		return
	end

	if self:_isMatchUnlock(sortId) then
		ImmortalMovementController.instance:unlockScore(self._activityId, sortId)
	end
end

function ImmortalMoveUnlockView:_onClickBtnStory()
	UIStateManager.instance:push(ViewName.ImmortalMoveStoryView, self._activityId)
end

return ImmortalMoveUnlockView
