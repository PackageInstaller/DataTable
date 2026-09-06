-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompBirthEff.lua

module("logicscene.scene.unit.component.UnitCompBirthEff", package.seeall)

local UnitCompBirthEff = class("UnitCompBirthEff", UnitComponentBase)

function UnitCompBirthEff:onInit()
	local res = rescache:GetResourceNoLoadIfNotExists(CommonResPath.SceneTransitionInEff)
	local mainAsset = res:GetMainAsset()

	self._birthInEff = goutil.clone(mainAsset, "TransitionInEff")

	self._birthInEff:SetActive(false)
	Framework.TransformUtil.SetLocalScale(self._birthInEff.transform, 0.1, 0.1, 0.1)
	GoUtil.SetSortingOrder(self._birthInEff, 10)
end

function UnitCompBirthEff:onDestroy()
	if self._birthInEff then
		goutil.destroy(self._birthInEff)

		self._birthInEff = nil
	end
end

function UnitCompBirthEff:update(deltaTime)
	self:_updateEffIn(deltaTime)
end

function UnitCompBirthEff:_updateEffIn(deltaTime)
	if self._playingEnterEff and self._birthInEff then
		if not self._birthInEff.activeSelf then
			self._timeCountIn = self._timeCountIn + deltaTime

			if self._timeCountIn >= 0.2 then
				self._timeCountIn = 0

				self._birthInEff:SetActive(true)
				self._unit:setVisible(true)
			end
		else
			self._timeCountIn = self._timeCountIn + deltaTime

			if self._timeCountIn >= 3 then
				self._timeCountIn = 0

				self:stopEnterScene()
			end
		end
	end
end

function UnitCompBirthEff:playEnterScene()
	self:stopEnterScene()

	if self._unit:isBodyLoaded() then
		self._playingEnterEff = true

		self._birthInEff:SetActive(false)

		self._timeCountIn = 0

		local go = self._unit.go
		local posx, posy, posz = Framework.TransformUtil.GetPos(go.transform, nil, nil, nil)

		Framework.TransformUtil.SetPos(self._birthInEff.transform, posx, posy, posz)
		self._unit:setVisible(false)
	end
end

function UnitCompBirthEff:stopEnterScene()
	if self._birthInEff then
		self._birthInEff:SetActive(false)
	end

	self._playingEnterEff = nil
	self._timeCountIn = 0
end

return UnitCompBirthEff
