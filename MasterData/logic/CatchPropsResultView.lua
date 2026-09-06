-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsResultView.lua

module("logic.extensions.catchprops.view.CatchPropsResultView", package.seeall)

local CatchPropsResultView = class("CatchPropsResultView", ViewComponent)

function CatchPropsResultView:buildUI()
	CatchPropsResultView.super.buildUI(self)

	self._btnClose = Framework.UIClickTrigger.Get(self:getGo("btnClose"))
	self._txtItemNum = self:getTxt("txtItemNum")
	self._itemsNode = self:getGo("itemsNode")
	self._awardsView = self:getGo("itemsNode/awardsView"):GetComponent(ComponentType.ScrollRect)
	self._awardsViewContent = self:getGo("itemsNode/awardsView/Viewport/Content").transform
	self._awardsVPSize = self:getGo("itemsNode/awardsView/Viewport").transform.rect.width

	local itemNode = self:getGo("itemsNode/awardsView/Viewport/Content/ItemNode")

	self._itemNodeLayout = itemNode:GetComponent(ComponentType.UILayoutSingleLine)

	local txtItemNumTips = self:getTxt("txtItemNumTips")
	local txtItems = self:getTxt("itemsNode/txtItems")

	txtItemNumTips.text = lang("catch_props_getprops_numtips")
	txtItems.text = lang("catch_props_getawards")
end

function CatchPropsResultView:bindEvents()
	CatchPropsResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function CatchPropsResultView:unbindEvents()
	CatchPropsResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function CatchPropsResultView:onEnter()
	CatchPropsResultView.super.onEnter(self)
	self:_updateAwards()

	self._txtItemNum.text = tostring(CatchPropsModel.instance:getGamePropsNum())
end

function CatchPropsResultView:onExitFinished()
	local nodeCnt = self._itemNodeLayout.transform.childCount

	for i = 1, nodeCnt do
		local go = self._itemNodeLayout.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end

	CatchPropsResultView.super.onExitFinished(self)
end

function CatchPropsResultView:_updateAwards()
	local changesetId = CatchPropsController.instance:getGameChangesetId()
	local awards = MaterialController.instance:getTempItemsByChangeSetId(changesetId)

	if not awards or #awards == 0 then
		self._itemsNode:SetActive(false)

		return
	end

	self._itemsNode:SetActive(true)

	local childCount = self._itemNodeLayout.transform.childCount
	local itemNum = #awards

	while childCount < itemNum do
		local go = goutil.create("prize" .. childCount + 1)

		go.transform:SetParent(self._itemNodeLayout.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, childCount * 115, 0, 0)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local data = awards[i]
		local go = self._itemNodeLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByMo(data, go)
	end

	for i = itemNum + 1, childCount do
		local go = self._itemNodeLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._itemNodeLayout:Layout()

	local contentSize = itemNum * 115
	local sizeDelta = self._awardsViewContent.sizeDelta

	sizeDelta.x = contentSize
	self._awardsViewContent.sizeDelta = sizeDelta
	self._awardsView.enabled = contentSize > self._awardsVPSize

	local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self._itemNodeLayout.transform, nil, nil, nil)

	if contentSize > self._awardsVPSize then
		Framework.TransformUtil.SetLocalPos(self._itemNodeLayout.transform, (contentSize - self._awardsVPSize) * 0.5, posY, posZ)
	else
		Framework.TransformUtil.SetLocalPos(self._itemNodeLayout.transform, 0, posY, posZ)
	end
end

function CatchPropsResultView:_onClickClose()
	self:close()

	if UIStateManager.instance:isInStack(ViewName.CatchPropsGameView) then
		UIStateManager.instance:pop()
	else
		UIStateManager.instance:push(ViewName.CatchPropsView)
	end
end

return CatchPropsResultView
