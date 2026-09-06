-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/LoadingViewBase.lua

module(..., package.seeall)

local LoadingViewBase = class("LoadingViewBase", ILoadingView)

function LoadingViewBase.createMainView()
	return nil
end

function LoadingViewBase:ctor(componetContainer)
	self._isWaitAndDoClose = false
	self.mainGO = componetContainer.gameObject
	self._compList = {}

	self:_initComponents()
	self:onInitComponent()
	self:onBuildView()
end

function LoadingViewBase:_initComponents()
	self:_addComponent("progress", LoadingCompProgress)
end

function LoadingViewBase:onInitComponent()
	self:notifyComponent("onInit")
end

function LoadingViewBase:OnDestroy()
	self:notifyComponent("onDestroy")
end

function LoadingViewBase:onBuildView()
	self:notifyComponent("onBuildView", self.mainGO)
end

function LoadingViewBase:destroy()
	goutil.destroy(self.mainGO)
end

function LoadingViewBase:show(isClear)
	self:notifyComponent("onEnter")

	if isClear then
		self:notifyComponent("onReset")
	end

	self._isWaitAndDoClose = false

	self.mainGO:SetActive(true)
	self:playEnterAnimation()
end

function LoadingViewBase:hide(forceHide)
	if self._isWaitAndDoClose == true and forceHide == false then
		return
	end

	if self.progress:isProgressing() == true then
		self._isWaitAndDoClose = true
	else
		self:notifyComponent("onHide")
		self:playExitAnimation()
	end
end

function LoadingViewBase:close()
	self:notifyComponent("onExit")
	self:notifyComponent("onReset")
	self.mainGO:SetActive(false)
end

function LoadingViewBase:isWaitAndDoClose()
	return self._isWaitAndDoClose
end

function LoadingViewBase:playEnterAnimation()
	self:_onEnterAnimationFinish()
end

function LoadingViewBase:playExitAnimation()
	self:_onExitAnimationFinish()
end

function LoadingViewBase:setTargetProgress(value)
	self.progress:setTargetProgress(value)
end

function LoadingViewBase:setLoadingTips(tips)
	self.progress:setLoadingTips(tips)
end

function LoadingViewBase:notifyComponent(funcName, ...)
	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i][funcName] then
			self._compList[i][funcName](self._compList[i], ...)
		end
	end
end

function LoadingViewBase:_onEnterAnimationFinish()
	self:notifyComponent("onEnterFinish")
end

function LoadingViewBase:_onExitAnimationFinish()
	self:close()
end

function LoadingViewBase:_addComponent(compName, compClass)
	local compInst = compClass.New(self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

return LoadingViewBase
