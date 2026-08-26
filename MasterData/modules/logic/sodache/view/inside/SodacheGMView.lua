-- chunkname: @modules/logic/sodache/view/inside/SodacheGMView.lua

module("modules.logic.sodache.view.inside.SodacheGMView", package.seeall)

local SodacheGMView = class("SodacheGMView", BaseView)

function SodacheGMView:onInitView()
	self._gogm = gohelper.findChild(self.viewGO, "#go_gm_test")
	self._goitem = gohelper.findChild(self.viewGO, "#go_gm_test/#go_item")
end

function SodacheGMView:onOpen()
	if not isDebugBuild then
		return
	end

	self._cloneItems = self:getUserDataTb_()

	TaskDispatcher.runRepeat(self._checkInput, self, 0, -1)
end

function SodacheGMView:_checkInput()
	if self._showDt then
		self._showDt = self._showDt - UnityEngine.Time.deltaTime
	end

	local isActive = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)
	local var_3_0

	if not isActive then
		::label_3_0::

		var_3_0 = self._showDt and self._showDt > 0
	end

	gohelper.setActive(self._gogm, var_3_0)

	if isActive then
		self._showDt = 0.5
	end

	if self._showDt and self._showDt > 0 then
		local mapGo = UnityEngine.GameObject.Find("cameraroot/SceneRoot/SodacheMapScene/map")
		local x, y, z = transformhelper.getPos(mapGo.transform)
		local insideMo = SodacheModel.instance:getInsideMo()

		for k, v in pairs(insideMo.mapCo.nodes) do
			if not self._cloneItems[k] then
				local go = gohelper.cloneInPlace(self._goitem)

				gohelper.setActive(go, true)

				self._cloneItems[k] = gohelper.findChildTextMesh(go, "")
			end

			local pos = v.pos
			local anchorX, anchorY = recthelper.worldPosToAnchorPosXYZ(pos.x + x, pos.y + y, pos.z + z, self._gogm.transform)

			recthelper.setAnchor(self._cloneItems[k].transform, anchorX, anchorY)

			local unitIds = ""
			local unitList = insideMo:getUnitsByNodeId(v.id)

			if insideMo.player.locationId == v.id then
				unitIds = unitIds .. "\n"
				unitIds = unitIds .. "<color=green>玩家自己</color>"
			end

			for _, vv in pairs(unitList) do
				if vv.eventCo then
					if not vv.eventCo.name then
						local unitName = ""

						unitIds = unitIds .. "\n"
						unitIds = unitIds .. vv.uid .. ":" .. vv.configId .. ".<color=green>" .. unitName .. "</color>"
					end
				end
			end

			self._cloneItems[k].text = string.format("[%s]%s", v.id, unitIds)
		end
	end
end

function SodacheGMView:onClose()
	TaskDispatcher.cancelTask(self._checkInput, self)
end

return SodacheGMView
