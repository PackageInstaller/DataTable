-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/notice/view/NoticeView.lua

module("logic.extensions.rank.view.NoticeView", package.seeall)

local NoticeView = class("NoticeView", ViewComponent)
local TAB_NAME = {
	[GameEnum.NoticeType.Activity] = lang("活动中心"),
	[GameEnum.NoticeType.Game] = lang("系统管理"),
	[GameEnum.NoticeType.MainTain] = lang("停服公告")
}

function NoticeView:ctor()
	NoticeView.super.ctor(self)
end

function NoticeView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function NoticeView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function NoticeView:buildUI()
	self._closeButton = self:getBtn("Close")
	self._contentBg = self:getGo("bg_webview")
	self._contentBgRt = self._contentBg:GetComponent("RectTransform")
	self._tableView = goutil.findChildComponent(self.mainGO, "tableview", "UITableview")
	self._tableCell = self:getGo("tablecell")

	goutil.setActive(self._tableCell, false)
end

function NoticeView:destroyUI()
	NoticeController.instance:closeNoticeView()
end

function NoticeView:onEnter()
	self.addGEvent(self, GlobalNotify.SceneResolutionChange, self._onSceneResolutionChange, self)
end

function NoticeView:onEnterFinished()
	if not NoticeModel.instance:hasAnyData() then
		TipsFacade.instance:openCommonTips(lang("当前没有公告哦"))
		self:_onClickClose()
	end

	self._tableView:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableView:SetOffsetWithoutRefresh(0)
	self._tableView:RegisterReloadFinishCallback(self._onReloadFinish)
	self:_setupTab()

	self._curSelectTopTabKey = -1

	if #NoticeModel.instance:getNoticeListByType(GameEnum.NoticeType.MainTain) > 0 then
		self:_onClickTopTab(GameEnum.NoticeType.MainTain)
	elseif #NoticeModel.instance:getNoticeListByType(GameEnum.NoticeType.Activity) > 0 then
		self:_onClickTopTab(GameEnum.NoticeType.Activity)
	elseif #NoticeModel.instance:getNoticeListByType(GameEnum.NoticeType.Game) > 0 then
		self:_onClickTopTab(GameEnum.NoticeType.Game)
	else
		self:_onClickTopTab(GameEnum.NoticeType.MainTain)
	end

	GlobalDispatcher:addListener(GlobalNotify.RoleInfoPushed, self._onClickClose, self)
end

function NoticeView:onExit()
	goutil.setActive(self.mainGO, true)
	removetimer(self._resetSize, self)
	self._tableView:UnRegisterAllCallbacks()
	NoticeController.instance:closeNoticeView()
	GlobalDispatcher:removeListener(GlobalNotify.RoleInfoPushed, self._onClickClose, self)
end

function NoticeView:onExitFinished()
	return
end

function NoticeView:_setupTab()
	for k, v in pairs(TAB_NAME) do
		local list = NoticeModel.instance:getNoticeListByType(k)
		local btn = self:getBtn("topTab/tab" .. k)
		local newFlag = self:getGo("topTab/tab" .. k .. "/new")

		btn:RemoveClickListener()
		newFlag:SetActive(NoticeModel.instance:hasNewNotices(k))

		if #list == 0 then
			btn.gameObject:SetActive(false)
		else
			btn.gameObject:SetActive(true)
			btn:AddClickListener(function()
				self:_onClickTopTab(k)
			end, self)
		end
	end
end

function NoticeView:_onClickTopTab(key)
	for k, v in pairs(TAB_NAME) do
		local goSelect = self:getGo("topTab/tab" .. k .. "/imgSelected")

		goSelect:SetActive(key == k)
	end

	if self._curSelectTopTabKey ~= key then
		self._tableViewDatas = NoticeModel.instance:getNoticeListByType(key)
		self._curSelectTopTabKey = key
		self._curSelectLeftTabIdx = -1

		self:_onClickTableCell(1)
	end
end

function NoticeView:_numInView()
	return #self._tableViewDatas
end

function NoticeView:_cellSize(view, index)
	return 212, 66
end

function NoticeView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)
	idx = idx + 1

	if idx <= 0 or idx > #self._tableViewDatas then
		return
	end

	local data = self._tableViewDatas[idx]
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local imgSelected = goutil.findChild(cell.gameObject, "imgSelected")
	local txtNameSelected = goutil.findChildTextComponent(imgSelected, "txtName")
	local newFlag = goutil.findChild(cell.gameObject, "new")

	txtName.text = data.title
	txtNameSelected.text = data.title

	imgSelected:SetActive(idx == self._curSelectLeftTabIdx)
	newFlag:SetActive(NoticeModel.instance:isNewNotice(data))
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickTableCell(idx)
	end, self)

	return cell
end

function NoticeView:_onReloadFinish()
	local data = self._tableViewDatas[self._curSelectLeftTabIdx]

	self:_calWebViewRect()

	local x = self._webViewRect.x
	local y = self._webViewRect.y
	local width = self._webViewRect.width
	local height = self._webViewRect.height

	printInfo("openWebView,x:" .. x .. ",y:" .. y)
	printInfo("openWebView,width:" .. width .. ",height:" .. height)
	printInfo("openWebView,UnityEngine.Screen.width:" .. UnityEngine.Screen.width)
	printInfo("openWebView,UnityEngine.Screen.height:" .. UnityEngine.Screen.height)

	if data then
		NoticeModel.instance:markNoticeRead(data)
		NoticeController.instance:openWebView(x, y, width, height, data)
	end
end

function NoticeView:_onClickTableCell(idx)
	if self._curSelectLeftTabIdx ~= idx then
		self._curSelectLeftTabIdx = idx

		self._tableView:ReloadData()
	end
end

function NoticeView:_onClickClose()
	self:close()
	NoticeController.instance:closeNoticeView()
	GlobalDispatcher:dispatch(GlobalNotify.CloseNotice)
end

function NoticeView:_onSceneResolutionChange()
	if NoticeBoard.getCurViewParam() then
		goutil.setActive(self.mainGO, false)
		settimer(0.06, self._resetSize, self, false)
	end
end

function NoticeView:_resetSize()
	self:_calWebViewRect()

	local x = self._webViewRect.x
	local y = self._webViewRect.y
	local width = self._webViewRect.width
	local height = self._webViewRect.height

	NoticeBoard.resetSize(x, y, width, height)
	goutil.setActive(self.mainGO, true)
end

function NoticeView:_calWebViewRect()
	local rect = Framework.GeometryUtil.GetUnityPixelRect(self._contentBgRt, GlobalModel.instance.uiCamera)

	printInfo("openWebView,uiCamera pixelHeight:" .. GlobalModel.instance.uiCamera.pixelHeight)
	printInfo("openWebView,rect rect.x:", rect.x)
	printInfo("openWebView,rect rect.y:", rect.y)
	printInfo("openWebView,rect rect.width:", rect.width)
	printInfo("openWebView,rect rect.height:", rect.height)

	local percent = SceneResolution.Instance.directPercent
	local _, oriy = SceneResolution.Instance:GetOriginalResolution(0, 0)
	local cy = oriy * percent

	printInfo("openWebView,rect cy:", cy)

	rect.y = cy - rect.y - rect.height

	printInfo("openWebView,percent:" .. percent)

	self._webViewRect = {
		x = math.floor(rect.x / percent),
		y = math.floor(rect.y / percent),
		width = math.floor(rect.width / percent),
		height = math.floor(rect.height / percent)
	}
end

return NoticeView
