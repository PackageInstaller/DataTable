-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookEventComp.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookEventComp", package.seeall)

local SurvivalHandbookEventComp = class("SurvivalHandbookEventComp", SurvivalHandbookViewComp)

function SurvivalHandbookEventComp:ctor(parentView)
	self._parentView = parentView
	self.handbookType = SurvivalEnum.HandBookType.Event
	self.ui3DPool = {}
	self.Shader = UnityEngine.Shader
end

function SurvivalHandbookEventComp:init(go)
	SurvivalHandbookEventComp.super.init(self, go)

	self.scroll = gohelper.findChild(go, "#scroll")
	self.tabs = {}

	local transNames = {
		"#btnTask",
		"#btnFight",
		"#btnSearch"
	}
	local HandBookEventSubType = SurvivalEnum.HandBookEventSubType
	local subTypes = {
		HandBookEventSubType.Task,
		HandBookEventSubType.Fight,
		HandBookEventSubType.Search
	}

	for i, name in ipairs(transNames) do
		local btnClick = gohelper.findChildButtonWithAudio(go, "tab/" .. name)
		local go_selected = gohelper.findChild(btnClick.gameObject, "#go_Selected")
		local go_redDot = gohelper.findChild(btnClick.gameObject, "#go_redDot")
		local subType = subTypes[i]
		local item = self:getUserDataTb_()

		item.btnClick = btnClick
		item.go_selected = go_selected
		item.go_redDot = go_redDot
		item.subType = subType

		table.insert(self.tabs, item)
		gohelper.setActive(go_selected, false)
		RedDotController.instance:addRedDot(go_redDot, RedDotEnum.DotNode.SurvivalHandbookEvent, subType)
	end

	local resPath = self._parentView.viewContainer:getSetting().otherRes.survivalhandbookeventitem

	self._item = self._parentView:getResInst(resPath, self.go)

	gohelper.setActive(self._item, false)

	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self.scroll, SurvivalSimpleListPart)

	self._simpleList:setCellUpdateCallBack(self.createItem, self, SurvivalHandbookEventItem, self._item)
	self:loadRainShader()
	self:loadLightGo()
	self:loadFogGo()
end

function SurvivalHandbookEventComp:loadFogGo()
	SurvivalSceneFogUtil.instance:loadFog(self.go)
end

function SurvivalHandbookEventComp:onOpen()
	self:selectTab(1, true)
end

function SurvivalHandbookEventComp:onClose()
	self:selectTab(nil)
end

function SurvivalHandbookEventComp:addEventListeners()
	for i, v in ipairs(self.tabs) do
		self.addClickCb(self, v.btnClick, self.onClickTab, self, i)
	end
end

function SurvivalHandbookEventComp:removeEventListeners()
	return
end

function SurvivalHandbookEventComp:onDestroy()
	TaskDispatcher.cancelTask(self._delayDestroyFog, self)

	for i, v in ipairs(self.ui3DPool) do
		UI3DRenderController.instance:removeSurvivalUI3DRender(v)
	end

	tabletool.clear(self.ui3DPool)

	if self.keyWord then
		self.Shader.DisableKeyword(self.keyWord)
	end

	if self._lightLoader then
		self._lightLoader:dispose()

		self._lightLoader = nil
	end

	SurvivalSceneAmbientUtil.instance:disable()
	SurvivalSceneFogUtil.instance:unLoadFog()

	if self._instGO then
		gohelper.destroy(self._instGO)

		self._instGO = nil
	end
end

function SurvivalHandbookEventComp:onClickTab(index)
	self:selectTab(index)
end

function SurvivalHandbookEventComp:createItem(obj, data, index)
	obj:setSurvivalHandbookEventComp(self)
	obj:updateMo(data)
end

function SurvivalHandbookEventComp:refreshList(isAnim)
	if self.curSelect == nil then
		self._simpleList:setList({})

		return
	end

	local datas = SurvivalHandbookModel.instance:getHandBookDatas(self.handbookType, self.tabs[self.curSelect].subType)

	table.sort(datas, SurvivalHandbookModel.instance.handBookSortFuncById)

	if isAnim then
		self._simpleList:setOpenAnimation(0.03)
	end

	self._simpleList:setList(datas)
end

function SurvivalHandbookEventComp:selectTab(tarSelect, isAnim)
	local haveChange = (not tarSelect or not self.curSelect or self.curSelect ~= tarSelect) and (not not tarSelect or not not self.curSelect)

	if haveChange then
		if self.curSelect then
			gohelper.setActive(self.tabs[self.curSelect].go_selected, false)
		end

		self.curSelect = tarSelect

		if self.curSelect then
			SurvivalHandbookController.instance:markNewHandbook(self.handbookType, self.tabs[self.curSelect].subType)
			gohelper.setActive(self.tabs[self.curSelect].go_selected, true)
		end

		self:refreshList(isAnim)
	end
end

function SurvivalHandbookEventComp:popSurvivalUI3DRender(texW, texH)
	local survivalUI3DRender
	local amount = #self.ui3DPool

	if amount <= 0 then
		survivalUI3DRender = UI3DRenderController.instance:getSurvivalUI3DRender(texW, texH)
	else
		survivalUI3DRender = self.ui3DPool[amount]
		self.ui3DPool[amount] = nil
	end

	return survivalUI3DRender
end

function SurvivalHandbookEventComp:pushSurvivalUI3DRender(survivalUI3DRender)
	table.insert(self.ui3DPool, survivalUI3DRender)
end

function SurvivalHandbookEventComp:loadRainShader()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.keyWord = outSideInfo.inWeek and weekInfo and SurvivalRainParam[weekInfo.rainType].KeyWord or SurvivalRainParam[SurvivalEnum.RainType.Rain1].KeyWord

	self.Shader.EnableKeyword(self.keyWord)
end

function SurvivalHandbookEventComp:getLightName()
	return "light3"
end

function SurvivalHandbookEventComp:loadLightGo()
	local name = self:getLightName()

	if not name then
		return
	end

	local assetPath = "survival/common/light/" .. name .. ".prefab"

	if not self._lightLoader then
		local go = gohelper.create3d(self.go, "Light")

		self._lightLoader = PrefabInstantiate.Create(go)
	end

	self._lightLoader:dispose()
	self._lightLoader:startLoad(assetPath, self._onLightLoaded, self)
end

function SurvivalHandbookEventComp:_onLightLoaded()
	SurvivalSceneAmbientUtil.instance:_onLightLoaded(self._lightLoader:getInstGO(), true)
end

return SurvivalHandbookEventComp
