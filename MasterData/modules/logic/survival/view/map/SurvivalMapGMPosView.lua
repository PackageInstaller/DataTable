-- chunkname: @modules/logic/survival/view/map/SurvivalMapGMPosView.lua

module("modules.logic.survival.view.map.SurvivalMapGMPosView", package.seeall)

local SurvivalMapGMPosView = class("SurvivalMapGMPosView", BaseView)

function SurvivalMapGMPosView:onInitView()
	self._gogm = gohelper.findChild(self.viewGO, "#go_gmpos")
	self._goitem = gohelper.findChild(self.viewGO, "#go_gmpos/#go_item")
end

function SurvivalMapGMPosView:onOpen()
	if not isDebugBuild then
		return
	end

	self._cloneItems = self:getUserDataTb_()

	TaskDispatcher.runRepeat(self._checkInput, self, 0, -1)
end

function SurvivalMapGMPosView:_checkInput()
	local isActive = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)

	gohelper.setActive(self._gogm, isActive)

	if isActive then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local screenWidth = UnityEngine.Screen.width
		local screenHeight = UnityEngine.Screen.height
		local v3 = Vector3(screenWidth / 2, screenHeight / 2, 0)
		local screenCenterPos = SurvivalHelper.instance:getScene3DPos(v3)
		local hex = SurvivalHexNode.New(SurvivalHelper.instance:worldPointToHex(screenCenterPos.x, screenCenterPos.y, screenCenterPos.z))

		for k, v in ipairs(SurvivalHelper.instance:getAllPointsByDis(hex, 10)) do
			if not self._cloneItems[k] then
				local go = gohelper.cloneInPlace(self._goitem)

				gohelper.setActive(go, true)

				self._cloneItems[k] = gohelper.findChildTextMesh(go, "")
			end

			local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(v.q, v.r)
			local anchorX, anchorY = recthelper.worldPosToAnchorPosXYZ(x, y, z, self._gogm.transform)

			recthelper.setAnchor(self._cloneItems[k].transform, anchorX, anchorY)

			local list = sceneMo:getListByPos(v)
			local unitIds = ""

			if list and list[1] then
				unitIds = "\nid:"

				for i = 1, #list do
					if i > 1 then
						unitIds = unitIds .. "、"
					end

					local unitMo = list[i]

					unitIds = unitIds .. unitMo.id
				end
			end

			self._cloneItems[k].text = string.format("[%d,%d]%s", v.q, v.r, unitIds)
		end
	end
end

function SurvivalMapGMPosView:onClose()
	TaskDispatcher.cancelTask(self._checkInput, self)
end

return SurvivalMapGMPosView
