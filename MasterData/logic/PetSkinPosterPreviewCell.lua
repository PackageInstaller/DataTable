-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetSkinPosterPreviewCell.lua

module("logic.extensions.petskinpreview.view.PetSkinPosterPreviewCell", package.seeall)

local PetSkinPosterPreviewCell = class("PetSkinPosterPreviewCell")

function PetSkinPosterPreviewCell.Get(go)
	local component = Framework.LuaComponentContainer.Get(go, PetSkinPosterPreviewCell)

	component = component or Framework.LuaComponentContainer.Add(go, PetSkinPosterPreviewCell)

	return component
end

function PetSkinPosterPreviewCell:ctor(comp)
	self._go = comp.gameObject
end

function PetSkinPosterPreviewCell:clear()
	local goCon = goutil.findChild(self._go, "container/mask/con")
	local typeChange = goutil.findChild(self._go, "container/layout/Nego_Type/skin")

	uGuiUtil.clearImage(typeChange)
	uGuiUtil.clearImage(goCon)
end

function PetSkinPosterPreviewCell:init(posterCfg)
	local goCon = goutil.findChild(self._go, "container/mask/con")
	local txtName = goutil.findChildTextComponent(self._go, "container/nameBg/txtName")
	local goType = goutil.findChild(self._go, "container/layout/Nego_Type")
	local goLock = goutil.findChild(self._go, "container/lock")
	local btnObj = goutil.findChild(self._go, "container/btnObj")
	local typeChange = goutil.findChild(self._go, "container/layout/Nego_Type/skin")
	local isHaveType = not string.nilorempty(posterCfg.skinTypeName)
	local isGet = true

	for i, skinId in ipairs(posterCfg.skinId) do
		if not PetSkinlPreviewController.instance:isHadSkin(skinId) then
			isGet = false

			break
		end
	end

	if not string.nilorempty(posterCfg.unlockItems) and isGet then
		local unlockItems = string.split(posterCfg.unlockItems, "#")

		for i, cfgStr in ipairs(unlockItems) do
			local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)

			isGet = matNum <= checknumber(MaterialModel.instance:getMaterialsNumber(matType, matId))

			if not isGet then
				break
			end
		end
	end

	uGuiUtil.clearImage(typeChange)

	if isHaveType then
		uGuiUtil.setSpriteToImage(typeChange, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("skintype", posterCfg.skinTypeName))
	end

	txtName.text = posterCfg.name

	goType:SetActive(isHaveType)
	GameUtil.addClickHandler(btnObj, function()
		self:_onClickPoster(posterCfg)
	end)
	goutil.setActive(goLock, not isGet)

	local imgPath = GameUrl.getBigbgFolderUrl("petskinpreview", posterCfg.previewResName)

	uGuiUtil.setSpriteToImage(goCon, uGuiUtil.SpriteType.BigBg, imgPath)
end

function PetSkinPosterPreviewCell:_onClickPoster(posterCfg)
	UIStateManager.instance:push(ViewName.PetskinposterView, posterCfg.posterId)
end

return PetSkinPosterPreviewCell
