-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleExtensionView.lua

module("logic.extensions.battle.viewmain.BattleExtensionView", package.seeall)

local BattleExtensionView = class("BattleExtensionView", ViewComponent)

function BattleExtensionView:buildUI()
	self._subViews = {}
end

function BattleExtensionView:destroyUI()
	self._subViews = nil
end

function BattleExtensionView:onEnter()
	self:_initSubViews()
	self:_setupSubViews()
	self:_notifySubViews(FunctionName.buildUI)
	self:_notifySubViews(FunctionName.unbindEvents)
	self:_notifySubViews(FunctionName.onEnter)
end

function BattleExtensionView:onExit()
	self:_notifySubViews(FunctionName.onExit)
	self:_notifySubViews(FunctionName.unbindEvents)
	self:_notifySubViews(FunctionName.destroyUI)
	self:_destroySubViews()
end

function BattleExtensionView:_initSubViews()
	local settingModel = BattleMgr.instance:getSettingModel()
	local viewClassList = settingModel:getExtensionViewClassList()

	for _, viewClass in pairs(viewClassList) do
		self:_addSubView(viewClass)
	end
end

function BattleExtensionView:_destroySubViews()
	for _, subView in ipairs(self._subViews) do
		goutil.destroy(subView.mainGO)

		subView.mainGO = false
	end

	BattleTableUtil.clearTable(self._subViews)
end

function BattleExtensionView:_setupSubViews()
	local resMgr = BattleMgr.instance:getResourceMgr()

	for _, subView in ipairs(self._subViews) do
		local respath = subView:dependMainResource()
		local inst = resMgr:getInst(respath)

		subView.mainGO = inst

		subView:setViewPresentor(self._viewPresentor)

		local parent = goutil.findChild(self.mainGO, subView:attachToWhichRoot())

		goutil.addChildToParent(inst, parent)
	end
end

function BattleExtensionView:_addSubView(viewComponent)
	table.insert(self._subViews, viewComponent)
end

function BattleExtensionView:_notifySubViews(functionName)
	for _, subView in ipairs(self._subViews) do
		subView[functionName](subView)
	end
end

return BattleExtensionView
