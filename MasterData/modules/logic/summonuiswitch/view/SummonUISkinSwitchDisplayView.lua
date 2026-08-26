-- chunkname: @modules/logic/summonuiswitch/view/SummonUISkinSwitchDisplayView.lua

module("modules.logic.summonuiswitch.view.SummonUISkinSwitchDisplayView", package.seeall)

local SummonUISkinSwitchDisplayView = class("SummonUISkinSwitchDisplayView", BaseView)

function SummonUISkinSwitchDisplayView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end

	self._cameraComp = SummonSceneCameraComp.New()

	self._cameraComp:onInit()
end

function SummonUISkinSwitchDisplayView:addEvents()
	return
end

function SummonUISkinSwitchDisplayView:removeEvents()
	return
end

function SummonUISkinSwitchDisplayView:_editableInitView()
	SummonUISkinSwitchDisplayController.instance:initMaps()
	self:_initSceneRoot()
end

function SummonUISkinSwitchDisplayView:onOpen()
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchSceneUI, self._onShowSceneInfo, self)
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.StartSwitchScene, self._onStartSwitchScene, self)

	if self.viewParam and self.viewParam.sceneId then
		if not self.viewParam.sceneId then
			local sceneId = SummonUISwitchModel.instance:getCurUseUI()

			self._curSceneType = SceneType.Summon
			self._curSceneId = SummonEnum.SummonSceneId

			local levelCOs = SceneConfig.instance:getSceneLevelCOs(self._curSceneId)

			if levelCOs and #levelCOs > 0 then
				self._curLevelId = levelCOs[1].id
			else
				logError("levelID Error in SummonScene : " .. tostring(self._curSceneId))
			end

			self._cameraComp:onSceneStart(self._curSceneId, self._curLevelId)
			self._cameraComp:switchToChar()
			self:_onShowSceneInfo(sceneId)
		end
	end
end

function SummonUISkinSwitchDisplayView:_onShowScene(id)
	SummonUISkinSwitchDisplayController.instance:showScene(id)
end

function SummonUISkinSwitchDisplayView:_initSceneRoot()
	local curScene = GameSceneMgr.instance:getCurScene()
	local curSceneRootGO = curScene and curScene:getSceneContainerGO()
	local rootGo = self:_getSceneRoot(curSceneRootGO)

	self._summonUISkinRoot = rootGo

	SummonUISkinSwitchDisplayController.instance:setSceneRoot(rootGo)
end

function SummonUISkinSwitchDisplayView:_getSceneRoot(root)
	local name = "summonSceneSkinRoot"
	local transform = root.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		if child.name == name then
			return child.gameObject
		end
	end

	return (gohelper.create3d(root, name))
end

function SummonUISkinSwitchDisplayView:_onStartSwitchScene()
	SummonUISkinSwitchDisplayController.instance:hideScene()
end

function SummonUISkinSwitchDisplayView:_onShowSceneInfo(id)
	self._curShowSceneId = id
	self._curSceneId = SummonUISwitchModel.instance:getCurUseUI()

	self:_onShowScene(id)
end

function SummonUISkinSwitchDisplayView:_changeToMainScene()
	self._prevShowSceneId = self._curShowSceneId

	SummonUISkinSwitchDisplayController.instance:hideScene()
end

function SummonUISkinSwitchDisplayView:resetCamera()
	self._cameraComp:onSceneClose()

	local scene = GameSceneMgr.instance:getCurScene()

	scene.camera:resetParam()
	scene.camera:applyDirectly()
	WeatherController.instance:FakeShowScene(true)
end

function SummonUISkinSwitchDisplayView:hideTab()
	gohelper.setActive(self._summonUISkinRoot, false)
	self:_changeToMainScene()
	self:resetCamera()
end

function SummonUISkinSwitchDisplayView:showTab()
	gohelper.setActive(self._summonUISkinRoot, true)
	self._cameraComp:switchToChar()
	WeatherController.instance:FakeShowScene(false)
end

function SummonUISkinSwitchDisplayView:isShowView()
	return self._isShowView
end

function SummonUISkinSwitchDisplayView:onTabSwitchOpen()
	self._isShowView = true

	self:showTab()
end

function SummonUISkinSwitchDisplayView:onTabSwitchClose()
	self._isShowView = false

	self:hideTab()
end

function SummonUISkinSwitchDisplayView:onClose()
	SummonUISkinSwitchDisplayController.instance:clear()
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchSceneUI, self._onShowSceneInfo, self)
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.StartSwitchScene, self._onStartSwitchScene, self)
	self:resetCamera()

	self._cameraComp = nil
end

function SummonUISkinSwitchDisplayView:onDestroyView()
	return
end

return SummonUISkinSwitchDisplayView
