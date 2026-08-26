-- chunkname: @modules/ugui/icon/common/CommonHeadIcon.lua

module("modules.ugui.icon.common.CommonHeadIcon", package.seeall)

local CommonHeadIcon = class("CommonHeadIcon", ListScrollCell)

function CommonHeadIcon:init(go)
	self.go = go
	self.tr = go.transform
	self._headIcon = gohelper.findChildSingleImage(go, "#simage_headicon")
	self._goframe = gohelper.findChild(go, "frame")
	self._imgaeheadIcon = gohelper.findChildImage(go, "#simage_headicon")
	self._imageframe = gohelper.findChildImage(go, "frame")
	self._goframenode = gohelper.findChild(go, "framenode")
	self._btnClick = gohelper.findChildClick(go, "#simage_headicon")
end

function CommonHeadIcon:addEventListeners()
	if self._btnClick then
		self._btnClick:AddClickListener(self._onClick, self)
	end
end

function CommonHeadIcon:removeEventListeners()
	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._btnClick = nil
	end
end

function CommonHeadIcon:_onClick()
	if self.noClick then
		return
	end

	if not self._materialType or not self._itemId then
		return
	end

	MaterialTipController.instance:showMaterialInfo(self._materialType, self._itemId)
end

function CommonHeadIcon:onUpdateMO(mo)
	self.mo = mo

	self:setItemId(mo.materilId, mo.materialType)
end

function CommonHeadIcon:setItemId(itemId, materialType)
	self._itemId = itemId
	self._materialType = materialType or MaterialEnum.MaterialType.Item
	self._config = ItemModel.instance:getItemConfigAndIcon(self._materialType, itemId)

	self:setHeadIcon()
	self:updateFrame()
	self:setVisible(true)
end

function CommonHeadIcon:setHeadIcon()
	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._headIcon)

	self._liveHeadIcon:setLiveHead(self._config.id)
end

function CommonHeadIcon:updateFrame()
	local effectArr = string.split(self._config.effect, "#")

	if #effectArr > 1 and self._config.id == tonumber(effectArr[#effectArr]) then
		gohelper.setActive(self._goframe, false)
		gohelper.setActive(self._goframenode, true)

		if not self.frame and not self.isloading then
			self.isloading = true

			local framePath = "ui/viewres/common/effect/frame.prefab"

			self._frameloader = MultiAbLoader.New()

			self._frameloader:addPath(framePath)
			self._frameloader:startLoad(self._onFrameLoadCallback, self)
		end
	else
		gohelper.setActive(self._goframe, true)
		gohelper.setActive(self._goframenode, false)
	end
end

function CommonHeadIcon:_onFrameLoadCallback()
	self.isloading = false

	local framePrefab = self._frameloader:getFirstAssetItem():GetResource()

	self.frame = gohelper.clone(framePrefab, self._goframenode, "frame")
end

function CommonHeadIcon:setColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._imgaeheadIcon, color)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageframe, color)
end

function CommonHeadIcon:setVisible(isVisible)
	if self.isVisible == isVisible then
		return
	end

	self.isVisible = isVisible

	gohelper.setActive(self.go, isVisible)
end

function CommonHeadIcon:setNoClick(noClick)
	self.noClick = noClick
end

function CommonHeadIcon:onDestroy()
	self._headIcon:UnLoadImage()
end

return CommonHeadIcon
