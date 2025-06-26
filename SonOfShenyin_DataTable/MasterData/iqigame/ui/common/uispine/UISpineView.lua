-- chunkname: @IQIGame\\UI\\Common\\UISpine\\UISpineView.lua

local UISpineView = {
	uniqueEntityID = 0,
	entityCid = 0
}

function UISpineView:_OnCreate(entityCid, parentTrans, targetTransform, callback)
	self.entityCid = entityCid
	self.__completeCallback = callback
	self.uniqueEntityID = EntityUtility.GetUIEntitySpineByCid(self.entityCid, parentTrans, Vector3.zero, function(_entityComponent)
		if _entityComponent.Id ~= self.uniqueEntityID then
			EntityUtility.HideEntity(_entityComponent)

			return
		end

		self.spineEntityGo = _entityComponent.gameObject

		LuaCodeInterface.BindOutlet(self.spineEntityGo, self)
		self:DisableClick()

		self.skeletonGraphic = self.spineEntityGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

		self.skeletonGraphic:Initialize(true)

		if targetTransform then
			self:RefreshPosition(targetTransform)
		end

		if self.__completeCallback ~= nil then
			self.__completeCallback()
		end
	end)

	function self.__delegateOnAnimationCallback()
		self:__AnimationComplete()
	end
end

function UISpineView:_PlayAnim(animName, isLoop, completeCallback)
	if self.skeletonGraphic == nil then
		return
	end

	if self.skeletonGraphic.AnimationState == nil then
		return
	end

	local animData = self.skeletonGraphic.AnimationState.Data.SkeletonData:FindAnimation(animName)

	if animData ~= nil then
		self.completeCallback = completeCallback

		self.skeletonGraphic.AnimationState:SetAnimation(0, animName, isLoop)

		self.skeletonGraphic.AnimationState.Complete = self.skeletonGraphic.AnimationState.Complete + self.__delegateOnAnimationCallback
	else
		logError("不存在" .. animName .. "动画")
	end
end

function UISpineView:__AnimationComplete()
	if self.completeCallback ~= nil then
		self.completeCallback()

		self.completeCallback = nil
	end

	self.skeletonGraphic.AnimationState.Complete = self.skeletonGraphic.AnimationState.Complete - self.__delegateOnAnimationCallback
end

function UISpineView:_Dispose()
	self:DisableClick()

	if self.spineEntityGo ~= nil then
		LuaCodeInterface.ClearOutlet(self.spineEntityGo, self)

		self.spineEntityGo = nil
	end

	self.skeletonGraphic = nil

	EntityUtility.HideEntityByEntityID(self.uniqueEntityID)

	self.uniqueEntityID = 0
end

function UISpineView:_Hide()
	self.spineEntityGo:SetActive(false)
end

function UISpineView:_Show()
	self.spineEntityGo:SetActive(false)
end

function UISpineView:RefreshPosition(transform)
	self.spineEntityGo.transform.localPosition = transform.localPosition
end

function UISpineView:DisableClick()
	if self.clickButtonRoot == nil then
		return
	end

	self:SetClickBtnState(false)

	if self.__delegateOnSpineClick ~= nil then
		self.clickButtonRoot:GetComponent("Button").onClick:RemoveListener(self.__delegateOnSpineClick)

		self.__delegateOnSpineClick = nil
	end
end

function UISpineView:EnableClick(callback)
	if self.clickButtonRoot == nil then
		return
	end

	function self.__delegateOnSpineClick()
		if callback ~= nil then
			callback()
		end
	end

	self.clickButtonRoot:GetComponent("Button").onClick:AddListener(self.__delegateOnSpineClick)
	self:SetClickBtnState(true)
end

function UISpineView:SetClickBtnState(state)
	self.clickButtonRoot.gameObject:SetActive(state)
end

function UISpineView:SetPosition(position)
	return
end

return UISpineView
