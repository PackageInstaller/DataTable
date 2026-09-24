-- chunkname: @modules/logic/college/view/other/CollegeChessMoveRouteView.lua

module("modules.logic.college.view.other.CollegeChessMoveRouteView", package.seeall)

local CollegeChessMoveRouteView = class("CollegeChessMoveRouteView", BaseView)

function CollegeChessMoveRouteView:addEvents()
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusBegin, self.onFocusBegin, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusCancel, self.onFocusCancel, self)
end

function CollegeChessMoveRouteView:removeEvents()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusBegin, self.onFocusBegin, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusCancel, self.onFocusCancel, self)
end

function CollegeChessMoveRouteView:onOpen()
	local str = CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.ChessMoveRouteInterval)
	local min, max

	if not string.nilorempty(str) then
		local arr = string.splitToNumber(str, "#")

		max = arr[2]
		min = arr[1]
	end

	min = min or 0
	max = max or 1

	local all = {}

	for i, v in ipairs(lua_college_actor.configList) do
		if not string.nilorempty(v.pieceAsset) then
			local path = string.format("modules/college/scene/prefab/%s.prefab", v.pieceAsset)

			all[path] = true
		end
	end

	self.allPath = {}

	for k in pairs(all) do
		table.insert(self.allPath, k)
	end

	self.poolPath = {}

	local pathGo = gohelper.find("cameraroot/SceneRoot/CollegeMapScene/root/city/res/v4a0_m_s08_college_p(Clone)/root/path")

	self.pathGo = pathGo
	self.pathComps = {}

	if pathGo then
		local trans = pathGo.transform

		for i = 0, trans.childCount - 1 do
			local child = trans:GetChild(i)
			local index = child.name:match("^path([0-9])$")

			index = tonumber(index)

			if index then
				local comp = MonoHelper.addNoUpdateLuaComOnceToGo(child.gameObject, CollegeChessRouteItem)

				comp:updateData(self.allPath, self.poolPath, index, min, max, self.onChessMoveStateChange, self)
				table.insert(self.pathComps, comp)
			end
		end
	end
end

function CollegeChessMoveRouteView:onFocusBegin()
	gohelper.setActive(self.pathGo, false)
end

function CollegeChessMoveRouteView:onFocusCancel()
	gohelper.setActive(self.pathGo, true)
end

function CollegeChessMoveRouteView:debugShowChess()
	self._debugloader = PrefabInstantiate.Create(self.pathGo)

	self._debugloader:startLoad(self.allPath[1], self._onDebugLoaded, self)
end

function CollegeChessMoveRouteView:_onDebugLoaded()
	local go = self._debugloader:getInstGO()

	for i, v in pairs(self.pathComps) do
		if v._clipLen then
			local root = gohelper.create3d(self.pathGo, "pathshow-" .. v._index)

			for time = 0, v._clipLen, 0.5 do
				v._clip:SampleAnimation(v.go, time)

				if v._chessGo.activeSelf then
					local newGo = gohelper.clone(go, root)

					newGo.transform.position = v._chessGo.transform.position
					newGo.transform.rotation = v._chessGo.transform.rotation
					newGo.transform.localScale = v._chessGo.transform.localScale

					local anim = gohelper.findComponentAnim(newGo)

					if anim then
						anim:Play("path")
					end
				end
			end
		end
	end
end

function CollegeChessMoveRouteView:onClose()
	self._moveCount = nil

	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.ChessMoveStop)
end

return CollegeChessMoveRouteView
