-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookView.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookView", package.seeall)

local SurvivalHandbookView = class("SurvivalHandbookView", BaseView)

function SurvivalHandbookView:onInitView()
	self.eventComp = gohelper.findChild(self.viewGO, "right/#eventComp")
	self.amplifierComp = gohelper.findChild(self.viewGO, "right/#amplifierComp")
	self.npcComp = gohelper.findChild(self.viewGO, "right/#npcComp")
	self.resultComp = gohelper.findChild(self.viewGO, "right/#resultComp")
	self.storyComp = gohelper.findChild(self.viewGO, "right/#storyComp")
	self.collectionComp = gohelper.findChild(self.viewGO, "right/#collectionComp")
	self.eventTab = gohelper.findChild(self.viewGO, "#go_tabcontainer/container/#eventTab")
	self.amplifierTab = gohelper.findChild(self.viewGO, "#go_tabcontainer/container/#amplifierTab")
	self.npcTab = gohelper.findChild(self.viewGO, "#go_tabcontainer/container/#npcTab")
	self.resultTab = gohelper.findChild(self.viewGO, "#go_tabcontainer/container/#resultTab")
	self.storyTab = gohelper.findChild(self.viewGO, "#go_tabcontainer/container/#storyTab")
	self.collectionTab = gohelper.findChild(self.viewGO, "#go_tabcontainer/container/#collectionTab")
	self.tabs = {}

	local tabGos = {
		self.eventTab,
		self.amplifierTab,
		self.npcTab,
		self.resultTab,
		self.storyTab,
		self.collectionTab
	}
	local HandBookType = SurvivalEnum.HandBookType
	local types = {
		HandBookType.Event,
		HandBookType.Amplifier,
		HandBookType.Npc,
		HandBookType.Result,
		HandBookType.Story,
		HandBookType.Collection
	}

	for i, go in ipairs(tabGos) do
		local tab = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalHandbookViewTab)

		tab:setData({
			index = i,
			type = types[i],
			onClickTabCallBack = self.onClickTab,
			onClickTabContext = self
		})
		table.insert(self.tabs, tab)
	end

	self.survivalHandbookEventComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.eventComp, SurvivalHandbookEventComp, self)
	self.survivalHandbookAmplifierComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.amplifierComp, SurvivalHandbookAmplifierComp, self)
	self.survivalHandbookNpcComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.npcComp, SurvivalHandbookNpcComp, self)
	self.survivalHandbookResultComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.resultComp, SurvivalHandbookResultComp, self)
	self.survivalHandbookStoryComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.storyComp, SurvivalHandbookStoryComp, self)
	self.survivalHandbookCollectionComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.collectionComp, SurvivalHandbookCollectionComp, self)
	self.fragment = {
		self.survivalHandbookEventComp,
		self.survivalHandbookAmplifierComp,
		self.survivalHandbookNpcComp,
		self.survivalHandbookResultComp,
		self.survivalHandbookStoryComp,
		self.survivalHandbookCollectionComp
	}

	for i, v in ipairs(self.fragment) do
		gohelper.setActive(v.go, true)

		v.canvasGroup.alpha = 0
		v.canvasGroup.blocksRaycasts = false
	end

	self.curSelect = nil
end

function SurvivalHandbookView:addEvents()
	return
end

function SurvivalHandbookView:onOpen()
	self:selectTab(1)
end

function SurvivalHandbookView:onClose()
	return
end

function SurvivalHandbookView:onDestroyView()
	return
end

function SurvivalHandbookView:onClickTab(survivalHandbookViewTab)
	self:selectTab(survivalHandbookViewTab.index)
end

function SurvivalHandbookView:selectTab(tarSelect)
	local haveChange = (not tarSelect or not self.curSelect or self.curSelect ~= tarSelect) and (not not tarSelect or not not self.curSelect)

	if haveChange then
		if self.curSelect then
			self.tabs[self.curSelect]:setSelect(false)
			self.fragment[self.curSelect]:onClose()

			local canvasGroup = self.fragment[self.curSelect].canvasGroup

			canvasGroup.alpha = 0
			canvasGroup.blocksRaycasts = false
		end

		self.curSelect = tarSelect

		if self.curSelect then
			self.tabs[self.curSelect]:setSelect(true)

			local canvasGroup = self.fragment[self.curSelect].canvasGroup

			canvasGroup.alpha = 1
			canvasGroup.blocksRaycasts = true

			self.fragment[self.curSelect]:onOpen()
		end
	end
end

return SurvivalHandbookView
