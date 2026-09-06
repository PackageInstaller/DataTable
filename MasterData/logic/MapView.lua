-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/map/view/MapView.lua

module("logic.extensions.map.view.MapView", package.seeall)

local MapView = class("MapView", ViewComponent)

function MapView:ctor()
	MapView.super.ctor(self)
end

function MapView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function MapView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function MapView:buildUI()
	self._closeButton = self:getBtn("lefttop/btnClose")
	self._btnHome = self:getBtn("lefttop/btn_home")

	self:_initMapNodes()

	self._goArrow = self:getGo("goArrow")
end

function MapView:_initMapNodes()
	self._cloneCell = self:getGo("cell")

	goutil.setActive(self._cloneCell, false)

	self._scenes = {}
	self._locks = {}

	local content = SceneConfig.instance:getSceneCfg()

	for k, v in pairs(content.dataList) do
		local go = self:getGo(tostring(v.id))

		if go then
			local cell = goutil.cloneAndSetParent(self._cloneCell, go.transform)

			cell.name = "cell"
			self._scenes[v.id] = go
			self._locks[v.id] = goutil.findChild(cell, "imgLock")

			Framework.TransformUtil.SetLocalPos(cell.transform, 0, 0, 0)
		end
	end
end

function MapView:_fillMapNodes()
	local content = SceneConfig.instance:getSceneCfg()

	for k, v in pairs(content.dataList) do
		local go = self._scenes[v.id]

		if go then
			local cell = goutil.findChild(go, "cell")
			local btn = Framework.ButtonAdapter.Get(go)
			local imgIcon = goutil.findChild(cell, "imgIcon")
			local txtName = goutil.findChildComponent(cell, "txtName", "Text")

			goutil.setActive(cell, true)
			btn:AddClickListener(function()
				if rescache.resLoadMode == Framework.ResourceLoadMode.RemoteAssetBundle then
					if v.id == 1001 or v.id == 118 or v.id == 103 or v.id == 104 then
						self:_onClickScene(v.id)
					else
						TipsFacade.instance:openPopupWindow(lang("tip"), "新手阶段手动跳转场景会触发资源下载，游戏可能会卡顿一小会儿，并且新地图可能出现显示不全，确定跳转吗？", function()
							self:_onClickScene(v.id)
						end, nil, lang("确定"), lang("取消"), UnityEngine.TextAnchor.MiddleCenter)
					end
				else
					self:_onClickScene(v.id)
				end
			end)

			txtName.text = v.scene_name

			uGuiUtil.setSpriteToImage(imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getSceneIconUrl(v.showImage))
		end
	end
end

function MapView:_clearMapNodes()
	local content = SceneConfig.instance:getSceneCfg()
	local compImageBigBG = typeof(Framework.ImageBigBG)

	for k, v in pairs(self._scenes) do
		local go = v
		local cell = goutil.findChild(go, "cell")
		local btn = Framework.ButtonAdapter.Get(go)
		local imgIcon = goutil.findChild(cell, "imgIcon")

		btn:RemoveClickListener()

		local bigBg = imgIcon:GetComponent(compImageBigBG)

		if bigBg then
			bigBg:ClearImage()
		end
	end
end

function MapView:_onClickScene(id)
	print("click scene id =" .. id)

	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("护送期间，不可手动切换场景！")

		return
	end

	if MountModel.instance:isTeamMountMember() then
		FloatWordMgr.instance:show("双人骑乘中无法传送！")

		return
	end

	local cfg = SceneConfig.instance:getSceneCo(id)

	if cfg then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGotoCity, cfg.scene_name)
	end

	local sceneMainPlayer = SceneMainPlayer.instance:getMainPlayer()

	sceneMainPlayer:stopAllActions()
	TaskController.instance:stopAction()
	SceneFacade.instance:enterCityFromThisScene(id)
end

function MapView:onEnter()
	goutil.setActive(self._goArrow, false)

	local curSceneId = SceneMgr.instance:getCurSceneId()
	local cfg = SceneConfig.instance:getSceneCo(curSceneId)

	for k, v in pairs(self._scenes) do
		if (k == curSceneId or k == cfg.mapViewId) and self._goArrow then
			local x, y, z = Framework.TransformUtil.GetPos(v.transform, 0, 0, 0)

			Framework.TransformUtil.SetPos(self._goArrow.transform, x, y, z)
			goutil.setActive(self._goArrow, true)

			break
		end
	end

	self:_fillMapNodes()

	for k, v in pairs(self._locks) do
		local isUnlock = UnlockFacade.instance:isSceneUnLock(k)

		goutil.setActive(v, not isUnlock)
	end

	local resPath = "fx_scene_dachangjing/fx_scene_dachangjing.prefab"

	self._bgEff = UIEffectManager.instance:playEffect(self, resPath, self.mainGO, 0, 0, true, false, nil, function(target, eff)
		goutil.addChildToParent(eff.effGo, self.mainGO)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 0.5, 0.5, 0.5)
	end)
end

function MapView:onExit()
	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)
	end

	self._bgEff = nil
end

function MapView:onExitFinished()
	self:_clearMapNodes()
end

function MapView:_onClickClose()
	UIStateManager.instance:pop()
end

function MapView:_onClickHome()
	UIStateManager.instance:clear(true)
end

return MapView
