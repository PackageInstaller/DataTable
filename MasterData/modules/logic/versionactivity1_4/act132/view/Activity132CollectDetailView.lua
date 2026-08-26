-- chunkname: @modules/logic/versionactivity1_4/act132/view/Activity132CollectDetailView.lua

module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailView", package.seeall)

local Activity132CollectDetailView = class("Activity132CollectDetailView", BaseView)

function Activity132CollectDetailView:onInitView()
	self.btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rightarrow")
	self.btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_leftarrow")
	self.simageRightBg = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_rightbg")
	self.simageImg = gohelper.findChildImage(self.viewGO, "Right/#simage_img")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Right/txt_Title")
	self.txtTitleEn = gohelper.findChildTextMesh(self.viewGO, "Right/txt_Title/txt_TitleEn")
	self.goContentItem = gohelper.findChild(self.viewGO, "Right/Scroll View/Viewport/Content/goContentItem")

	gohelper.setActive(self.goContentItem, false)

	self.contentItemList = {}
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "emptyBg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity132CollectDetailView:addEvents()
	self.addClickCb(self, self.btnRightArrow, self.onClickRightBtn, self)
	self.addClickCb(self, self.btnLeftArrow, self.onClickLeftBtn, self)
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
	self.addEventCb(self, Activity132Controller.instance, Activity132Event.OnContentUnlock, self.onContentUnlock, self)
end

function Activity132CollectDetailView:removeEvents()
	self:removeClickCb(self.btnRightArrow)
	self:removeClickCb(self.btnLeftArrow)
	self:removeClickCb(self.btnClose)
	self.removeEventCb(self, Activity132Controller.instance, Activity132Event.OnContentUnlock, self.onContentUnlock, self)
end

function Activity132CollectDetailView:_editableInitView()
	self.simageRightBg:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_rightbg.png")
end

function Activity132CollectDetailView:onUpdateParam()
	self.actId = self.viewParam.actId
	self.collectId = self.viewParam.collectId
	self.clueId = self.viewParam.clueId

	self:refreshUI()
end

function Activity132CollectDetailView:onOpen()
	self.actId = self.viewParam.actId
	self.collectId = self.viewParam.collectId
	self.clueId = self.viewParam.clueId

	self:refreshUI()
end

function Activity132CollectDetailView:onClickRightBtn()
	local actMo = Activity132Model.instance:getActMoById(self.actId)
	local collectMo = actMo:getCollectMo(self.collectId)
	local list = collectMo:getClueList()
	local count = #list
	local curIndex

	for i, v in ipairs(list) do
		if v.clueId == self.clueId then
			curIndex = i

			break
		end
	end

	if curIndex then
		local index = curIndex + 1

		if index < 1 then
			index = count
		end

		if count < index then
			index = 1
		end

		Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, index)
	end
end

function Activity132CollectDetailView:onClickLeftBtn()
	local actMo = Activity132Model.instance:getActMoById(self.actId)
	local collectMo = actMo:getCollectMo(self.collectId)
	local list = collectMo:getClueList()
	local count = #list
	local curIndex

	for i, v in ipairs(list) do
		if v.clueId == self.clueId then
			curIndex = i

			break
		end
	end

	if curIndex then
		local index = curIndex - 1

		if index < 1 then
			index = count
		end

		if count < index then
			index = 1
		end

		Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, index)
	end
end

function Activity132CollectDetailView:refreshUI()
	local collectCfg = Activity132Config.instance:getCollectConfig(self.actId, self.collectId)
	local clueCfg = Activity132Config.instance:getClueConfig(self.actId, self.clueId)
	local name = collectCfg.name
	local first = GameUtil.utf8sub(name, 1, 1)
	local nameLen = GameUtil.utf8len(name)

	self.txtTitle.text = string.format("<size=66>%s</size>%s", first, (nameLen >= 2 or nil) and GameUtil.utf8sub(name, 2, nameLen - 1))
	self.txtTitleEn.text = collectCfg.nameEn

	UISpriteSetMgr.instance:setV1a4CollectSprite(self.simageImg, clueCfg.smallBg, true)
	self:refreshContents()
end

function Activity132CollectDetailView:refreshContents()
	local actMo = Activity132Model.instance:getActMoById(self.actId)
	local collectMo = actMo:getCollectMo(self.collectId)
	local clueMo = collectMo:getClueMo(self.clueId)
	local contentList = clueMo:getContentList()
	local list = {}
	local canUnlockList = {}

	for i, v in ipairs(contentList) do
		local state = actMo:getContentState(v.contentId)

		table.insert(list, v)

		if state == Activity132Enum.ContentState.CanUnlock then
			table.insert(canUnlockList, v.contentId)
		end
	end

	local itemCount = #self.contentItemList
	local dataCount = #list

	for i = 1, math.max(itemCount, dataCount) do
		local item = self.contentItemList[i]

		if not item then
			item = self:createContentItem(i)

			table.insert(self.contentItemList, item)
		end

		item:setData(list[i])
	end

	if #canUnlockList > 0 then
		Activity132Rpc.instance:sendAct132UnlockRequest(self.actId, canUnlockList)
	end
end

function Activity132CollectDetailView:createContentItem(index)
	local go = gohelper.cloneInPlace(self.goContentItem, string.format("item%s", index))

	return Activity132CollectDetailItem.New(go)
end

function Activity132CollectDetailView:onContentUnlock(contents)
	if not contents then
		return
	end

	local dict = {}

	for i = 1, #contents do
		dict[contents[i]] = 1
	end

	for i, v in ipairs(self.contentItemList) do
		if v.data and dict[v.data.contentId] then
			v:playUnlock()
		end
	end
end

function Activity132CollectDetailView:onClickClose()
	self:closeThis()
end

function Activity132CollectDetailView:onDestroyView()
	self.simageRightBg:UnLoadImage()
end

return Activity132CollectDetailView
