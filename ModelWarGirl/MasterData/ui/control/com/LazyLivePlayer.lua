-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\LazyLivePlayer.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "LazyLivePlayer"
local LazyLivePlayer = Class(strClassName, UIBaseControl)
local AnimatorType = typeof(UnityEngine.Animator)

function LazyLivePlayer:ctor(parent, path)
	return
end

function LazyLivePlayer:_getControlType()
	return UIConst.ControlTypeLazyLivePlayer
end

function LazyLivePlayer:playLive2DByPath(livePath, scale, coord)
	if coord then
		self:setPosition(coord[1], coord[2])
	end

	local obj = self:getComObj()

	if obj then
		if scale then
			obj.Scale = scale
		end

		local ret = obj:PlayLiveWithPath(livePath)

		return ret
	end
end

function LazyLivePlayer:PlayLive2DAnimator(livePath, scale)
	local obj = self:getComObj()

	if obj then
		if scale then
			obj.Scale = scale
		end

		return obj:PlayAnimator(livePath)
	end
end

function LazyLivePlayer:getAnimator()
	if self.animCom == nil then
		local obj = self:getComObj()

		if obj then
			local live2d = obj:GetLivePrefab()

			if live2d then
				local anim = live2d.transform:GetComponent(AnimatorType)

				if anim then
					self.animCom = anim
				end
			end
		end
	end

	if not self.animCom or tolua.isnull(self.animCom) then
		local obj = self:getComObj()

		self.animCom = obj:GetComponentInChildren(AnimatorType)
	end

	return self.animCom
end

function LazyLivePlayer:setBoolParam(param, state)
	local anim = self:getAnimator()

	if anim then
		anim:SetBool(param, state)
	end
end

function LazyLivePlayer:playState(state)
	local anim = self:getAnimator()

	if anim then
		anim:Play(state, -1, 0)
	end
end

function LazyLivePlayer:setSortOrder(orderValue)
	local obj = self:getComObj()

	if obj then
		obj.SortOrder = orderValue

		obj:RefreshSortingOrder()
	end
end

function LazyLivePlayer:getRealCurAnim()
	if not self._realAnim then
		local obj = self:getComObj()

		self._realAnim = obj:GetComponentInChildren(AnimatorType)
	end

	return self._realAnim
end

function LazyLivePlayer:setPlaySpeed(speedScale)
	local anim = self:getAnimator()

	if anim ~= nil then
		anim.speed = speedScale
	end
end

return LazyLivePlayer
