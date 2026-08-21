-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mgr/UIFocusMgr.lua

module("logic.common.mgr.UIFocusMgr", package.seeall)

local M = {}
local Vector2 = UnityEngine.Vector2
local goFrameImage, imgFrame
local maxHistoryCount = 3
local targetHistory = {}
local defaultScale = Vector2.one
local defaultPath = "grid_9"
local defaultIconType = IconType.Skinlib
local urlView = ResName.Ui_focus
local Vector2Zero = Vector2.zero
local Vector2One = Vector2.one
local loader, focusId
local finishLoadCallback = {}

EventType.UI_FOCUS_CHANGE = UIDUtil.getEventUID()

function M.setFrameSprite(iconType, path)
	if not goutil.isNil(goFrameImage) and imgFrame then
		IconLoader.setSprite(imgFrame, iconType, path)
		M.setImageType(UnityEngine.UI.Image.Type.Sliced)
	end
end

function M.setImageType(imgType)
	if not goutil.isNil(goFrameImage) and imgFrame then
		imgFrame.type = imgType
	end
end

function M.setShowChild(childName)
	if not goutil.isNil(goFrameImage) then
		for i = 0, goFrameImage.transform.childCount - 1 do
			local tra = goFrameImage.transform:GetChild(i)

			if tra.name == childName then
				goutil.setActive(tra.gameObject, true)
			else
				goutil.setActive(tra.gameObject, false)
			end
		end
	else
		local temp = childName

		table.insert(finishLoadCallback, function()
			M.setShowChild(temp)
		end)
	end
end

function M.setColor(color)
	if not goutil.isNil(goFrameImage) and imgFrame then
		Astral.ColorUtil.SetImageColor(imgFrame, color)
	end
end

function M.setOffset(offsetX, offsetY, scaleX, scaleY)
	if not goutil.isNil(goFrameImage) then
		local tra = goFrameImage.transform
		local pos = tra.localPosition

		pos.x = pos.x + offsetX or 0
		pos.y = pos.y + offsetY or 0
		tra.localPosition = pos
		tra.localScale = Vector2.New(scaleX or 1, scaleY or 1)
	end
end

function M.setFocus(targetGo, siblingIndex, objId, path, iconType)
	if goutil.isNil(targetGo) then
		return
	end

	table.insert(targetHistory, {
		targetGo = targetGo,
		siblingIndex = siblingIndex,
		objId = objId,
		path = path,
		iconType = iconType
	})

	if #targetHistory > maxHistoryCount then
		table.remove(targetHistory, 1)
	end

	if goutil.isNil(goFrameImage) then
		loader = SingleResLoader.New()

		loader:load(urlView, M._onResourceLoaded)

		return
	end

	focusId = objId

	if targetGo then
		goutil.addChildToParent(goFrameImage, targetGo)

		local rect = goFrameImage.transform

		rect.anchorMin = Vector2Zero
		rect.anchorMax = Vector2One
		rect.offsetMin = Vector2Zero
		rect.offsetMax = Vector2Zero
		siblingIndex = siblingIndex or rect.childCount - 1

		rect:SetSiblingIndex(siblingIndex)

		rect.localScale = defaultScale
	end

	goutil.setActive(goFrameImage, true)
	GlobalDispatcher:dispatchEvent(EventType.UI_FOCUS_CHANGE, {
		isShow = true,
		objId = objId
	})

	if path then
		M.setFrameSprite(iconType, path)
	else
		M.setFrameSprite(defaultIconType, defaultPath)
	end
end

function M.setFocusObjectId(objId)
	focusId = objId
end

function M.getFocusObjectId()
	return focusId
end

function M._onResourceLoaded(resource)
	if resource.IsSuccess then
		local asset = resource:GetAsset(nil, nil)

		if asset then
			goFrameImage = goutil.clone(asset)
			imgFrame = goFrameImage.transform:Find("normal"):GetComponent(typeof(UnityEngine.UI.Image))

			M.resumeFocus()

			for k, v in pairs(finishLoadCallback) do
				v()
			end

			finishLoadCallback = {}

			loader:clear()

			return
		end
	end
end

function M.hideFocus(objId)
	if objId and objId ~= focusId then
		return
	end

	goutil.setActive(goFrameImage, false)
	GlobalDispatcher:dispatchEvent(EventType.UI_FOCUS_CHANGE, {
		isShow = false,
		objId = focusId
	})
end

function M.resumeFocus()
	if #targetHistory > 0 then
		local last = targetHistory[#targetHistory]

		M.setFocus(last.targetGo, last.siblingIndex, last.objId, last.path, last.iconType)
		table.remove(targetHistory, #targetHistory)
	end
end

return M
