-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StorySubCgViewComponent.lua

module("logic.extensions.story.view.StorySubCgViewComponent", package.seeall)

local M = class("StorySubCgViewComponent", ViewComponent)

function M:buildUI()
	self._subCGObj = self:getGo("story_main_view_-1384023992")
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.OnSubCgEnter, self._onSubCgShow, self)
	StoryDispatcher:addEventListener(StoryNotifyName.OnSubCgExit, self._onSubCgClose, self)

	self._curProxyCg = false
	self._hasExistCg = false
	self._cgIndex = 0
	self.cgProxyList = {}
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.OnSubCgEnter, self._onSubCgShow, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.OnSubCgExit, self._onSubCgClose, self)
	goutil.setActive(self._subCGObj, false)
	table.clear(self.cgProxyList)
end

function M:_onSubCgShow(evt, subCgData, subCgObj)
	self._isHoldCg = subCgData.isHoldCg

	local isCloseCg = subCgData.isCloseCg
	local targetPos = subCgData.targetPos
	local cgPath = subCgData.cgPath

	if isCloseCg then
		if self._curProxyCg then
			local animationCom = self._curProxyCg.target:GetComponent(ComponentType.Animation)
			local animSelectListener = Astral.AnimationEventListener.Get(self._curProxyCg.target)

			animSelectListener:AddListener(self._dealAnimEvent, self)

			if animationCom then
				local animName = string.format("%s_close", self._curProxyCg.target.name)

				animationCom:Play(animName)
			end
		end

		return
	end

	self._cgIndex = self._cgIndex + 1

	table.insert(self.cgProxyList, subCgObj)

	if self._hasExistCg then
		self._curProxyCg = self.cgProxyList[#self.cgProxyList]

		self:setImageInfo(cgPath)

		local animationCom = false

		if self.cgProxyList[#self.cgProxyList - 1] and not goutil.isNil(self.cgProxyList[#self.cgProxyList - 1]) then
			animationCom = self.cgProxyList[#self.cgProxyList - 1].target:GetComponent(ComponentType.Animation)

			local animSelectListener = Astral.AnimationEventListener.Get(self.cgProxyList[#self.cgProxyList - 1].target)

			animSelectListener:AddListener(self._dealAnimEvent, self)

			if animationCom then
				local animName = string.format("%s_close", self.cgProxyList[#self.cgProxyList - 1].target.name)

				animationCom:Play(animName)
			end
		else
			local animSelectListener = Astral.AnimationEventListener.Get(self.cgProxyList[#self.cgProxyList].target)

			animSelectListener:AddListener(self._dealAnimEvent, self)

			animationCom = self._cgProxy2.target:GetComponent(ComponentType.Animation)

			if animationCom then
				local animName = string.format("%s_open", self.cgProxyList[#self.cgProxyList].target.name)

				animationCom:Play(animName)
			end
		end

		goutil.addChildToParent(subCgObj, self._subCGObj)
		self._curProxyCg.transform:SetAsFirstSibling()
	else
		self._curProxyCg = self.cgProxyList[#self.cgProxyList]

		self:setImageInfo(cgPath)

		local animationCom = self._curProxyCg.target:GetComponent(ComponentType.Animation)

		if animationCom then
			local animName = string.format("%s_open", self._curProxyCg.target.name)

			animationCom:Play(animName)
		end

		goutil.addChildToParent(subCgObj, self._subCGObj)
	end

	self._hasExistCg = true

	goutil.setActive(self._subCGObj, true)
	GameUtils.setLocalPos(subCgObj.proxyTarget, targetPos.x, targetPos.y, targetPos.z)
	goutil.setActive(subCgObj.proxyTarget, true)
end

function M:_dealAnimEvent(animEvent)
	if animEvent then
		local curIndex = animEvent.intParameter

		if curIndex == 0 then
			-- block empty
		elseif curIndex == 1 then
			self._cgIndex = self._cgIndex - 1

			if self._cgIndex <= 0 then
				goutil.setActive(self._subCGObj, false)
				goutil.clearChildren(self._subCGObj)

				self._cgProxy1 = false
				self._cgProxy2 = false

				table.clear(self.cgProxyList)

				self._curProxyCg = false
				self._hasExistCg = false
			end
		end
	end
end

function M:setImageInfo(cgPath)
	local cgBgGo = goutil.findChild(self._curProxyCg.target, "cgBg")
	local sceneCO = StorySceneConfig.instance:getPlotSceneInfoCO(tonumber(cgPath))

	if sceneCO then
		local cgTexUrl = StoryLogicResPathUtils.Get2DSceneTextureUrl(sceneCO.bgPath)

		self._cgTexUrl = cgTexUrl

		if cgTexUrl and self._curProxyCg then
			local imageBigBG = UIComponentType.ImageBigBG(cgBgGo)

			imageBigBG:SetNativeSize(true)
			imageBigBG:SetImage(cgTexUrl, nil, self)
		end
	end
end

function M:_onSubCgClose(evt, data)
	if data and data.isHoldCg then
		return
	end

	if self._curProxyCg then
		local animationCom = self._curProxyCg.target:GetComponent(ComponentType.Animation)
		local animSelectListener = Astral.AnimationEventListener.Get(self._curProxyCg.target)

		animSelectListener:AddListener(self._dealAnimEvent, self)

		if animationCom then
			local animName = string.format("%s_close", self._curProxyCg.target.name)

			animationCom:Play(animName)
		end
	end
end

function M:destroyUI()
	return
end

return M
