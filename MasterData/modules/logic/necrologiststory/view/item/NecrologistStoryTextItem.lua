-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryTextItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryTextItem", package.seeall)

local NecrologistStoryTextItem = class("NecrologistStoryTextItem", NecrologistStoryBaseItem)

function NecrologistStoryTextItem:onInit()
	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "content/txtContent")

	local resPath = self:getOtherResPath()[1]
	local res = self:getRes(resPath)

	self.txtComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtContent.gameObject, NecrologistStoryTextComp, {
		wordRes = res
	})
	self.linkItemList = {}
end

function NecrologistStoryTextItem:onPlayStory(isSkip)
	self:refreshText(isSkip)
end

function NecrologistStoryTextItem:refreshText(isSkip)
	local storyConfig = self:getStoryConfig()
	local desc, hasLink = NecrologistStoryHelper.getDescByConfig(storyConfig)

	self.hasLink = hasLink

	if self:hasLinkGuide() then
		isSkip = false

		local mo = NecrologistStoryModel.instance:getCurStoryMO()

		mo:setIsAuto(false)
	end

	local param = string.splitToNumber(storyConfig.param, "#")

	if not param[1] then
		self.txtComp:setAnimType(param[1])

		if isSkip and self.txtComp:isCanSkip() then
			self.txtComp:setTextNormal(desc, self.onTextFinish, self)
		else
			self.txtComp:setTextWithAnim(desc, self.onFrameUpdateText, self.onTextFinish, self)
		end
	end
end

function NecrologistStoryTextItem:onFrameUpdateText()
	local height = self:caleHeight()

	if not self.lastHeight or math.abs(self.lastHeight - height) > 0.1 then
		self.lastHeight = height

		self:refreshHeight()
	end
end

function NecrologistStoryTextItem:onTextFinish()
	if self.hasLink then
		TaskDispatcher.runDelay(self.createLinksRect, self, 0.02)
	end

	self:onPlayFinish()
end

function NecrologistStoryTextItem:createLinksRect()
	local list = NecrologistStoryHelper.calculateLinksRectData(self.txtContent)

	for i, v in ipairs(list) do
		self:createLinkRectItem(v)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnLinkText)
end

function NecrologistStoryTextItem:createLinkRectItem(data)
	local centerPos, width, height, linkId = unpack(data)

	if self.linkItemList[linkId] then
		return
	end

	local item = self:getUserDataTb_()

	item.linkId = linkId
	item.go = gohelper.create2d(self.txtContent.gameObject, "link" .. linkId)
	item.transform = item.go.transform

	recthelper.setAnchor(item.transform, centerPos.x, centerPos.y)
	recthelper.setSize(item.transform, width, height)

	item.image = gohelper.onceAddComponent(item.go, gohelper.Type_Image)
	item.image.raycastTarget = true

	ZProj.UGUIHelper.SetColorAlpha(item.image, 0)

	item.btn = gohelper.getClick(item.go)

	item.btn:AddClickListener(self.onClickLink, self, linkId)

	self.linkItemList[linkId] = item

	return item
end

function NecrologistStoryTextItem:onClickLink(linkId)
	NecrologistStoryHelper.defaultClick(linkId)
end

function NecrologistStoryTextItem:getLinkRectGO()
	local list = NecrologistStoryHelper.calculateLinksRectData(self.txtContent)

	for i, v in ipairs(list) do
		local _, _, _, linkId = unpack(v)
		local item = self.linkItemList[linkId]

		if item then
			return item.go
		end
	end
end

function NecrologistStoryTextItem:caleHeight()
	return self.txtContent.preferredHeight
end

function NecrologistStoryTextItem:isDone()
	return self.txtComp:isDone()
end

function NecrologistStoryTextItem:hasLinkGuide()
	return self.hasLink and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryLinkText)
end

function NecrologistStoryTextItem:justDone()
	if self:hasLinkGuide() or not self.txtComp:isCanSkip() then
		return
	end

	self.txtComp:onTextFinish()
end

function NecrologistStoryTextItem:getTextStr()
	return self.txtComp and self.txtComp:getTextStr()
end

function NecrologistStoryTextItem:onDestroy()
	if self.hasLink then
		TaskDispatcher.cancelTask(self.createLinksRect, self)
	end

	if self.linkItemList then
		for k, v in pairs(self.linkItemList) do
			v.btn:RemoveClickListener()
		end
	end
end

function NecrologistStoryTextItem.getOtherResPath()
	return {
		"ui/viewres/dungeon/rolestory/item/necrologiststoryword.prefab"
	}
end

return NecrologistStoryTextItem
