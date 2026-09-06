-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/SpineBoneBinder.lua

module("logic.extensions.spineinterface.comp.SpineBoneBinder", package.seeall)

local SpineBoneBinder = class("SpineBoneBinder")

function SpineBoneBinder:ctor()
	self._followers = {}
	self._spineGo = nil
	self._skeletonList = nil
	self._spineLoadHelp = nil
	self._meshAttType = nil
	self._compType = nil
	self._bfgType = nil
	self._skeletonGraphicType = nil
	self._skeletonGraphicCache = {}
end

function SpineBoneBinder:onLoad(spineGo, skeletonList, spineLoadHelp)
	self:onUnLoad()

	self._spineGo = spineGo
	self._skeletonList = skeletonList
	self._spineLoadHelp = spineLoadHelp
	self._meshAttType = SystemReflexHelp.getType("Spine.MeshAttachment")
	self._compType = spineLoadHelp and spineLoadHelp:getCompType() or nil

	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		self._bfgType = typeof(Spine.Unity.BoneFollowerGraphic)
		self._skeletonGraphicType = typeof(Spine.Unity.SkeletonGraphic)
	end
end

function SpineBoneBinder:onUnLoad()
	for _, info in ipairs(self._followers) do
		if not goutil.isNil(info.go) then
			self:_stopFollowComponent(info.go)
			GameUtil.SetActive(info.go, false)
		end
	end

	table.clear(self._followers)

	self._spineGo = nil
	self._skeletonList = nil
	self._spineLoadHelp = nil
	self._compType = nil
	self._bfgType = nil
	self._skeletonGraphicType = nil

	table.clear(self._skeletonGraphicCache)
end

function SpineBoneBinder:begin(go, slotName, allowMultiple, alwaysVisible)
	if goutil.isNil(go) or string.nilorempty(slotName) then
		return
	end

	if not self._skeletonList then
		return
	end

	if not allowMultiple then
		for i = #self._followers, 1, -1 do
			local info = self._followers[i]

			if info.slotName == slotName and info.go ~= go then
				if not goutil.isNil(info.go) then
					self:_stopFollowComponent(info.go)
					GameUtil.SetActive(info.go, false)
				end

				table.remove(self._followers, i)
			end
		end
	end

	local targetSlot, targetSkeletonIdx

	for idx, skeleton in ipairs(self._skeletonList) do
		local slot = skeleton:FindSlot(slotName)

		if slot then
			targetSlot = slot
			targetSkeletonIdx = idx

			break
		end
	end

	if targetSlot == nil then
		return
	end

	local bone = SystemReflexHelp.getBoneOfSpineSlot(targetSlot)

	if not bone then
		return
	end

	local boneName = SystemReflexHelp.getBoneNameOfSpineBone(bone)

	if string.nilorempty(boneName) then
		return
	end

	local hostTransform = self._spineGo.transform

	if self._spineLoadHelp then
		local compList = self._spineLoadHelp:getCompList()

		if compList and compList[targetSkeletonIdx] then
			hostTransform = compList[targetSkeletonIdx].gameObject.transform
		end
	end

	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		self:_beginFollowGraphic(go, hostTransform, boneName)
	else
		Spine.Unity.BoneFollower.BeginFollow(go, hostTransform, 0, 0, boneName, 0, 0, 0, true, true, false, true, 0, 0, false, false, false, false)
	end

	local visible = alwaysVisible or self:_isMeshAttachmentVisible(targetSlot)

	GameUtil.SetActive(go, visible)

	local info = {
		go = go,
		slot = targetSlot,
		slotName = slotName,
		lastVisible = visible,
		alwaysVisible = alwaysVisible or false,
		lastAttachment = SystemReflexHelp.getAttachmentOfSpineSlot(targetSlot)
	}

	table.insert(self._followers, info)
end

function SpineBoneBinder:stop(go)
	if goutil.isNil(go) then
		return
	end

	for i = #self._followers, 1, -1 do
		if self._followers[i].go == go then
			self:_stopFollowComponent(go)
			GameUtil.SetActive(go, false)
			table.remove(self._followers, i)

			break
		end
	end
end

function SpineBoneBinder:onUpdate()
	if #self._followers == 0 then
		return
	end

	for _, info in ipairs(self._followers) do
		if not info.alwaysVisible and info.slot ~= nil then
			local attachment = SystemReflexHelp.getAttachmentOfSpineSlot(info.slot)

			if attachment ~= info.lastAttachment then
				info.lastAttachment = attachment

				local visible = attachment ~= nil and attachment:GetType() == self._meshAttType

				if visible ~= info.lastVisible then
					info.lastVisible = visible

					if not goutil.isNil(info.go) then
						GameUtil.SetActive(info.go, visible)
					end
				end
			end
		end
	end
end

function SpineBoneBinder:_isMeshAttachmentVisible(slot)
	local attachment = SystemReflexHelp.getAttachmentOfSpineSlot(slot)

	if attachment and attachment:GetType() == self._meshAttType then
		return true
	end

	return false
end

function SpineBoneBinder:_beginFollowGraphic(go, hostTransform, boneName)
	local comp = go:GetComponent(self._bfgType)

	comp = comp or go:AddComponent(self._bfgType)

	local skeletonGraphic = self._skeletonGraphicCache[hostTransform]

	if not skeletonGraphic then
		skeletonGraphic = hostTransform:GetComponentInChildren(self._skeletonGraphicType, true)
		self._skeletonGraphicCache[hostTransform] = skeletonGraphic
	end

	comp.skeletonGraphic = skeletonGraphic
	comp.boneName = boneName
	comp.followZPosition = true
	comp.followBoneRotation = true
	comp.followLocalScale = false
	comp.followSkeletonFlip = true
	comp.enabled = true

	comp:Initialize()
end

function SpineBoneBinder:_stopFollowComponent(go)
	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		local comp = go:GetComponent(self._bfgType)

		if comp then
			comp.enabled = false
		end
	else
		Spine.Unity.BoneFollower.StopFollow(go)
	end
end

return SpineBoneBinder
