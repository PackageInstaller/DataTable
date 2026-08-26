-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheDiceResultItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheDiceResultItem", package.seeall)

local SodacheDiceResultItem = class("SodacheDiceResultItem", LuaCompBase)
local rotationDict = {
	Vector3(90, 0, 0),
	Vector3(90, 90, 0),
	Vector3(90, 180, 0),
	Vector3(90, -90, 0),
	Vector3(0, 0, 0),
	(Vector3(180, 0, 0))
}

function SodacheDiceResultItem:init(go)
	self.go = go
	self._anim = gohelper.findComponentAnim(go)

	self:initTextures()
	self:initDiceMeshes()
end

function SodacheDiceResultItem:initTextures()
	self._textures = self:getUserDataTb_()

	local root = gohelper.findChild(self.go, "__ref_texture")

	if not root then
		return
	end

	local trans = root.transform

	for i = 0, trans.childCount - 1 do
		local child = trans:GetChild(i)
		local id = tonumber(child.name)
		local rawImage = child:GetComponent(typeof(UnityEngine.UI.RawImage))

		if id and rawImage then
			self._textures[id] = rawImage.texture
		end
	end
end

function SodacheDiceResultItem:initDiceMeshes()
	self._diceRoot = gohelper.findChild(self.go, "touzi_ani/touzi").transform
	self._uimeshes = self:getUserDataTb_()

	for i = 0, self._diceRoot.childCount - 1 do
		local diceMesh = self._diceRoot:GetChild(i)
		local diceNum = tonumber(diceMesh.name) or 1

		self._uimeshes[diceNum] = diceMesh:GetComponent(typeof(UIMesh))
	end
end

function SodacheDiceResultItem:setData(data)
	local diceId = data.diceId
	local diceCo = lua_sodache_dice.configDict[diceId]
	local arr = string.splitToNumber(diceCo.faceList, "#") or {}

	self._anim:Play("in")

	for i, v in ipairs(arr) do
		local uiMesh = self._uimeshes[i]
		local texture = self._textures[v]

		if uiMesh and texture then
			uiMesh.texture = texture

			uiMesh:SetMaterialDirty()
		end
	end

	local toIndex = Mathf.Clamp(data.faceIndex + 1, 1, 6)

	self._fromRotate = Vector3.New(math.random(2000, 5000), math.random(2000, 5000), math.random(2000, 5000))
	self._toRotate = rotationDict[toIndex]

	transformhelper.setLocalRotation(self._diceRoot, self._fromRotate.x, self._fromRotate.y, self._fromRotate.z)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.1, self.onTween, nil, self, nil, EaseType.InOutCubic)
end

function SodacheDiceResultItem:onTween(value)
	local x = Mathf.Lerp(self._fromRotate.x, self._toRotate.x, value)
	local y = Mathf.Lerp(self._fromRotate.y, self._toRotate.y, value)
	local z = Mathf.Lerp(self._fromRotate.z, self._toRotate.z, value)

	transformhelper.setLocalRotation(self._diceRoot, x, y, z)
end

function SodacheDiceResultItem:onDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return SodacheDiceResultItem
