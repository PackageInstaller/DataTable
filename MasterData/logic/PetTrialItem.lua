-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/view/PetTrialItem.lua

module("logic.extensions.pettrial.view.PetTrialItem", package.seeall)

local PetTrialItem = class("PetTrialItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function PetTrialItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, PetTrialItem)

	component = component or LuaComponentContainer.Add(go, PetTrialItem)

	return component
end

local cellLinePos = {
	{
		0,
		80,
		1,
		148,
		4,
		136
	},
	{
		71,
		-42,
		4,
		131,
		2,
		157
	},
	{
		71,
		-42,
		4,
		148,
		1,
		184
	},
	{
		71,
		-42,
		4,
		150,
		1,
		76
	},
	{
		71,
		41,
		4,
		133,
		2,
		154
	},
	{
		0,
		-85,
		2,
		140,
		4,
		237,
		1,
		90
	}
}
local cellPos = {
	{
		14.3,
		-32.6
	},
	{
		9.4,
		153.5
	},
	{
		-2.1,
		-128.6
	},
	{
		-7,
		97.7
	},
	{
		0,
		215.6
	},
	{
		-9.7,
		18.5
	}
}
local pivot = {
	Vector2.New(0, 0.5),
	Vector2.New(1, 0.5),
	Vector2.New(1, 0.5),
	(Vector2.New(0, 0.5))
}
local rotationZ = {
	90,
	90,
	0,
	0
}
local offset = {
	{
		0,
		1
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	}
}

function PetTrialItem:ctor(go)
	goutil.setActive(go.gameObject, true)

	local cellGo = goutil.findChild(go, "cell")

	self._cellGo = cellGo:GetComponent("RectTransform")

	local linesGo = goutil.findChild(go, "cell/lines")

	self.itemIcon = goutil.findChild(cellGo, "itemIcon")
	self.petIcon = goutil.findChildComponent(cellGo, "mask/petIcon", "Image")
	self.txtLevelName = goutil.findChildComponent(cellGo, "levelName/txtLevelName", "Text")
	self.canSweep = goutil.findChild(cellGo, "canSweep")
	self.txtSweepDes = goutil.findChildComponent(cellGo, "canSweep/txtSweepDes", "Text")
	self.petIconMat = self.petIcon.material
	self.btn = Framework.ButtonAdapter.Get(cellGo)
	self.changeGroup = linesGo:GetComponent("UIChangeGroup")
	self.changeGroupCell = cellGo:GetComponent("UIChangeGroup")
	self.imgChange = goutil.findChildComponent(cellGo, "levelName", "UIImageSpriteChange")
	self.imgChange2 = goutil.findChildComponent(cellGo, "canSweep", "UIImageSpriteChange")
	self.imgKuang = goutil.findChild(cellGo, "imgKuang")
	self.rawImage = goutil.findChildComponent(cellGo, "rawImg", "RawImage")
	self.photoEff = PhotoEffect.Get(self.rawImage.gameObject)
	self.imgLock = goutil.findChild(cellGo, "img_Lock")
	self.txtTip = goutil.findChildComponent(cellGo, "txt_tip", "Text")
	self._lines = {}

	for i = 1, 3 do
		local line = goutil.findChildComponent(linesGo, "line" .. i, "RectTransform")

		table.insert(self._lines, line)
	end

	self._points = {}

	for i = 1, 2 do
		local point = goutil.findChildComponent(linesGo, "point" .. i, "RectTransform")

		table.insert(self._points, point)
	end
end

function PetTrialItem:onSetMo(mo, len, idx)
	local modelCo = CharacterConfig.instance:getModelCo(mo.petId)

	uGuiUtil.setSpriteToImage(self.petIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

	self.txtLevelName.text = mo.name

	local str = string.split(mo.gift, "#")

	MaterialMgr.setCellByCfg(str[1], self.itemIcon)
	self:_updateLines(idx)
	goutil.setActive(self.changeGroup.gameObject, idx < len)
	self:_updateStatus(mo, idx)

	local pos = cellPos[(idx - 1) % 6 + 1]

	Framework.TransformUtil.SetAnchoredPos(self._cellGo, pos[1], pos[2])
end

function PetTrialItem:_updateStatus(mo, idx)
	local stageId = PetTrialModel.instance:getCurStageId()
	local teamId = PetTrialModel.instance:getCurTeamId()
	local curChallengeId = PetTrialModel.instance:getCurChallengeId()
	local isLight = PetTrialModel.instance:getIsLighted(idx) and PetTrialModel.instance:getIsOpen(idx)
	local isClearAll = PetTrialModel.instance:getIsClearAll(idx)
	local state = 0

	if isClearAll then
		state = 1
	elseif curChallengeId == idx then
		state = 2
	end

	self.imgChange:SetState(state)
	self.imgChange2:SetState(state)

	if not isLight then
		self.petIcon.material = self.petIconMat or nil
	end

	if self.sweepEff ~= nil then
		self.sweepEff:setActive(isClearAll)
	elseif isClearAll then
		self.sweepEff = UIEffectManager.instance:playHUDEffect("fx_ui_jinglingshilian/fx_ui_jinglingshilian_kesaodang.prefab", self.canSweep, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self.canSweep) + 1)

			eff.effGo.transform.localScale = Vector3.one

			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, -10)
		end, nil, false)
	end

	self.btn:RemoveClickListener()
	self.btn:AddClickListener(function()
		PetTrialController.instance:localNotify("OnClickLevelItem", idx, self)
	end, self)
	self.changeGroup:SetState(isClearAll and 0 or 1)
	self.changeGroupCell:SetState(isLight and 0 or 1)
	goutil.setActive(self.rawImage.gameObject, idx == curChallengeId)
	self:_playEffect(idx == curChallengeId)

	local isOpen, lv = PetTrialModel.instance:getIsOpen(idx)

	goutil.setActive(self.imgLock, not isOpen)
	goutil.setActive(self.txtTip.gameObject, not isOpen)
	goutil.setActive(self.canSweep, isOpen)

	self.txtTip.text = string.format("人物等级%s级开启", lv)
end

function PetTrialItem:_onClickLevel(id)
	return
end

function PetTrialItem:onDispose()
	print("on dispose")

	if self.sweepEff ~= nil then
		UIEffectManager.instance:stopEffect(self.sweepEff)

		self.sweepEff = nil
	end

	if self.photoEff ~= nil then
		self.photoEff:clear()
	end

	if self._eff ~= nil then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function PetTrialItem:_updateLines(i)
	local linesInfo = cellLinePos[(i - 1) % 6 + 1]

	for _, line in ipairs(self._lines) do
		goutil.setActive(line.gameObject, false)
	end

	for _, point in ipairs(self._points) do
		goutil.setActive(point.gameObject, false)
	end

	local lineIdx = 1
	local pointIdx = 0

	if linesInfo then
		local i = 3
		local startPos = {
			linesInfo[1],
			linesInfo[2]
		}

		while i <= #linesInfo do
			local direction = linesInfo[i]
			local len = linesInfo[i + 1]
			local off = offset[direction]
			local line = self._lines[lineIdx]

			lineIdx = lineIdx + 1

			goutil.setActive(line.gameObject, true)
			self:_updateLine(line, linesInfo[i], linesInfo[i + 1], startPos[1], startPos[2])

			local point = self._points[pointIdx]

			pointIdx = pointIdx + 1

			if point ~= nil then
				goutil.setActive(point.gameObject, true)
				Framework.TransformUtil.SetAnchoredPos(point, startPos[1], startPos[2])
			end

			startPos[1] = startPos[1] + off[1] * len
			startPos[2] = startPos[2] + off[2] * len
			i = i + 2
		end
	end
end

function PetTrialItem:_updateLine(rect, direction, len, posX, posY)
	local childRect = goutil.findChildComponent(rect.gameObject, "GameObject", "RectTransform")

	childRect.offsetMax = direction > 2 and Vector2.New(4.6, 0.2) or Vector2.New(-4.6, 0.2)
	childRect.offsetMin = direction > 2 and Vector2.New(4.6, -10.8) or Vector2.New(-4.6, -10.8)
	rect.pivot = pivot[direction]
	rect.sizeDelta = Vector2.New(len, 2)

	Framework.TransformUtil.SetAnchoredPos(rect, posX, posY)
	Framework.TransformUtil.SetLocalRotation(rect.transform, 0, 0, rotationZ[direction])
end

function PetTrialItem:_playEffect(isChallenging)
	if isChallenging then
		self.photoEff:showEffects("effect/prefabs/ui/fx_ui_jinglingshilian/fx_ui_jinglingshilian_ketiaozhan_dianji.prefab")
	else
		self.photoEff:clear()
	end

	if self._eff ~= nil then
		self._eff:setActive(isChallenging)
	elseif isChallenging then
		self._eff = UIEffectManager.instance:playHUDEffect("fx_ui_jinglingshilian/fx_ui_jinglingshilian_ketiaozhan.prefab", self.canSweep, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self.canSweep) + 1)

			eff.effGo.transform.localScale = Vector3.one

			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, -10)
		end, nil, false)
	end
end

return PetTrialItem
