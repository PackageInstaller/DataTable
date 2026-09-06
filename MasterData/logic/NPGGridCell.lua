-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/ui/NPGGridCell.lua

module("logic.extensions.numberpuzzlegame.view.ui.NPGGridCell", package.seeall)

local NPGGridCell = class("NPGGridCell")

function NPGGridCell:ctor()
	self._defaultLocalScale = Vector3.New()

	self:onReset()
end

function NPGGridCell:onDispose()
	return
end

function NPGGridCell:onReset()
	self._mainGo = nil
	self._icon = nil
	self._txtNum = nil
	self._effRoot = nil

	self._defaultLocalScale:Set(1, 1, 1)
end

function NPGGridCell:onInit(mainGo)
	self._mainGo = mainGo
	self._icon = goutil.findChild(mainGo, "icon")
	self._txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	self._effRoot = goutil.findChild(mainGo, "effRoot")
end

function NPGGridCell:getGameObject()
	return self._mainGo
end

function NPGGridCell:getWidth()
	return GameUtil.getWidth(self._mainGo)
end

function NPGGridCell:getHeight()
	return GameUtil.getHeight(self._mainGo)
end

function NPGGridCell:setActive(isActive)
	GameUtil.SetActive(self._mainGo, isActive)
end

function NPGGridCell:setLocalScale(x, y, z)
	GameUtil.setLocalScale(self._mainGo, x, y, z)
end

function NPGGridCell:getLocalScale()
	return GameUtil.getLocalScale(self._mainGo)
end

function NPGGridCell:resetLocalScale()
	self:setLocalScale(self:getDefaultLocalScale())
end

function NPGGridCell:initDefaultLocalScale(x, y, z)
	self._defaultLocalScale:Set(x, y, z)
end

function NPGGridCell:getDefaultLocalScale()
	return self._defaultLocalScale:Get()
end

function NPGGridCell:getPos()
	GameUtil.getPos(self._mainGo)
end

function NPGGridCell:setPos(x, y, z)
	GameUtil.setPos(self._mainGo, x, y, z)
end

function NPGGridCell:setLocalPos(x, y, z)
	GameUtil.setLocalPos(self._mainGo, x, y, z)
end

function NPGGridCell:setName(name)
	self._txtNum.text = name
end

function NPGGridCell:_loadIcon(path)
	self:_loadBigBg(self._icon, path, false)
end

function NPGGridCell:_unLoadIcon()
	self:_unLoadBigBg(self._icon)
end

function NPGGridCell:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function NPGGridCell:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

return NPGGridCell
