-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\RoleImage.lua

local ResRoleImageData = require("ClientData/ResRoleImageData")
local ResRoleFaceData = require("ClientData/ResRoleFaceData")
local AvgConfig = require("DesignerScript/AvgConfig")
local LoaderFactory = Framework.Resource.LoaderFactory
local LoaderMode = Framework.Resource.LoaderMode
local strClassName = "RoleImage"
local RoleImage = Class(strClassName, UIControls.Child)
local DEF_ATLAS_PATH = "Atlas/CommonAtlas/HeroPortraitAtlas/"

function RoleImage:ctor(parent, url, prefabPath, x, y, defaultVisible, delayInit)
	self._basePos = {
		x or 0,
		y or 0
	}
	self._baseScale = 1

	self:initUI()
end

function RoleImage:initUI(...)
	self.image = UIControls.Image(self, "")
	self.imgEmoji = UIControls.Image(self, "Emoji")
end

function RoleImage:showRole(roleID, showType)
	self._roleID = roleID
	self._roleData = ResRoleImageData[roleID]

	if self._roleData == nil then
		return
	end

	self._atlasName = DEF_ATLAS_PATH .. self._roleData.res_path

	self.image:setImage(self._atlasName, self._roleData.res_name)
	self.image:setSize(self._roleData.size[1], self._roleData.size[2])

	self._faceData = ResRoleFaceData[roleID]

	if self._faceData and self._faceData[1] then
		local faceSize = self._faceData[1].size

		if faceSize then
			self.imgEmoji:setSize(faceSize[1], faceSize[2])
		end

		local facePos = self._faceData[1].pos

		if facePos then
			self.imgEmoji:setPosition(facePos[1], facePos[2])
		end

		local faceScale = self._faceData[1].scale

		if faceScale then
			self.imgEmoji:setScale(faceScale)
		end
	end

	self.imgEmoji:setVisible(false)

	if not self._roleData.scale or not self._roleData.pos then
		self._roleData.scale = 1
		self._roleData.pos = {
			0,
			0
		}
	end

	self._baseScale = self._roleData.scale
	self._basePos = self._roleData.pos

	if showType and self._roleData[showType] then
		self._baseScale = self._roleData[showType][1].scale
		self._basePos = self._roleData[showType][1].pos
	end

	self:_setBaseScale()
	self:_setBasePos()

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function RoleImage:_setBaseScale()
	self:setScale(1)
end

function RoleImage:_setBasePos()
	self:setPosition(0, 0)
end

function RoleImage:setPosition(x, y)
	if self._basePos then
		x = x + self._basePos[1]
		y = y + self._basePos[2]
	end

	RoleImage.super.setPosition(self, x, y)
end

function RoleImage:setAbsPosition(x, y)
	RoleImage.super.setPosition(self, x, y)
end

function RoleImage:moveToPosition(x, y, moveTime)
	if self._basePos then
		x = x + self._basePos[1]
		y = y + self._basePos[2]
	end

	RoleImage.super.moveToPosition(self, x, y, moveTime)
end

function RoleImage:setScale(scale)
	scale = scale * self._baseScale

	self.image:setScale(scale)
end

function RoleImage:setImageAndEmojiByRGBA(R, G, B, A)
	if R and G and B then
		local a = A or 255

		self.image:setColorByRGBA(R, G, B, a)
		self.imgEmoji:setColorByRGBA(R, G, B, a)
	end
end

function RoleImage:setActive(active)
	if active then
		self.image:setColorByRGBA(255, 255, 255)
		self.imgEmoji:setColorByRGBA(255, 255, 255)
	else
		self.image:setColorByRGBA(AvgConfig.ROLE_GRAY_COLOR[1], AvgConfig.ROLE_GRAY_COLOR[2], AvgConfig.ROLE_GRAY_COLOR[3])
		self.imgEmoji:setColorByRGBA(AvgConfig.ROLE_GRAY_COLOR[1], AvgConfig.ROLE_GRAY_COLOR[2], AvgConfig.ROLE_GRAY_COLOR[3])
	end
end

function RoleImage:setGray(isGray)
	self.image:setObjGray(isGray)
end

function RoleImage:showEmoji(index)
	if not index then
		return
	end

	if not self._faceData or not self._faceData[index] then
		self.imgEmoji:setVisible(false)

		return
	end

	local faceData = self._faceData[index]

	self.imgEmoji:setVisible(true)
	self.imgEmoji:setImage(DEF_ATLAS_PATH .. faceData.res_path, faceData.res_name)
end

function RoleImage:clearEmoji(...)
	self.imgEmoji:setVisible(false)
end

function RoleImage:changeMaterial(materialPath, callback)
	local loader = LoaderFactory.LoadFile(materialPath, LoaderMode.Async, Functor(self._changeMaterialCallback, self, materialPath, callback))
	local isComplete = loader.IsCompleted

	if isComplete and callback then
		self:_changeMaterialCallback(materialPath, callback, true, loader)
	end
end

function RoleImage:_changeMaterialCallback(materialPath, callback, state, loader)
	local image = self.image:getComObj()

	if image then
		image.material = loader.AsyncResult
	end
end

return RoleImage
