-- chunkname: @modules/logic/survival/view/map/SurvivalMapBubbleView.lua

module("modules.logic.survival.view.map.SurvivalMapBubbleView", package.seeall)

local SurvivalMapBubbleView = class("SurvivalMapBubbleView", BaseView)

function SurvivalMapBubbleView:onInitView()
	self._goBubble = gohelper.findChild(self.viewGO, "Bubble")
	self._goNormal = gohelper.findChild(self.viewGO, "Bubble/normal")
	self._txtNormalPlace = gohelper.findChildTextMesh(self.viewGO, "Bubble/normal/image_Bubble/#txt_place")
	self._txtNormalTime = gohelper.findChildTextMesh(self.viewGO, "Bubble/normal/image_Bubble/#txt_place/#txt_time")
	self._goSpecial = gohelper.findChild(self.viewGO, "Bubble/special")
	self._txtSpecialPlace = gohelper.findChildTextMesh(self.viewGO, "Bubble/special/image_Bubble/#txt_place")
	self._txtSpecialTime = gohelper.findChildTextMesh(self.viewGO, "Bubble/special/image_Bubble/#txt_place/#txt_time")
	self._txtSpecialDesc = gohelper.findChildTextMesh(self.viewGO, "Bubble/special/image_Bubble/#txt_dec")
end

function SurvivalMapBubbleView:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapCostTimeUpdate, self._onCostTimeUpdate, self)
end

function SurvivalMapBubbleView:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapCostTimeUpdate, self._onCostTimeUpdate, self)
end

function SurvivalMapBubbleView:onOpen()
	self._txtNormalPlace.text = luaLang("survival_mapblockname")
	self._pathFollowGo = gohelper.create3d(GameSceneMgr.instance:getCurScene():getSceneContainerGO(), "[follow]")

	local uiFollower = gohelper.onceAddComponent(self._goBubble, typeof(ZProj.UIFollower))
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	uiFollower:Set(mainCamera, uiCamera, plane, self._pathFollowGo.transform, 0, 0, 0, 0, 0)
	uiFollower:SetEnable(true)
	self:_onCostTimeUpdate()
end

function SurvivalMapBubbleView:_onCostTimeUpdate(paths)
	if paths then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local pos = paths[#paths]
		local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

		transformhelper.setLocalPos(self._pathFollowGo.transform, x, y, z)

		local blockCo = sceneMo:getBlockCoByPos(pos)

		gohelper.setActive(self._goNormal, not blockCo)
		gohelper.setActive(self._goSpecial, blockCo)

		local time = SurvivalMapModel.instance.showCostTime
		local hour = math.floor(time / 60)
		local min = time % 60
		local timeStr = string.format("%02d:%02d", hour, min)

		if blockCo then
			self._txtSpecialPlace.text = blockCo.name
			self._txtSpecialDesc.text = blockCo.preAttrDesc
			self._txtSpecialTime.text = timeStr
		else
			self._txtNormalTime.text = timeStr
		end
	else
		gohelper.setActive(self._goNormal, false)
		gohelper.setActive(self._goSpecial, false)
	end
end

function SurvivalMapBubbleView:onClose()
	gohelper.destroy(self._pathFollowGo)
end

return SurvivalMapBubbleView
