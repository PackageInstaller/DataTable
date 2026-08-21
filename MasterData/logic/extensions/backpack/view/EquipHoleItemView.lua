-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/EquipHoleItemView.lua

module("logic.extensions.backpack.view.EquipHoleItemView", package.seeall)

local M = class("EquipHoleItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._transform = self._mainGo.transform
	self._imgDiGo = goutil.findChild(self._mainGo, "imgDi")
	self._imgHoleIcon = goutil.findChildImageComponent(self._mainGo, "unlock/imgHoleIcon")

	self._imgHoleIcon.gameObject:SetActive(true)

	self._txtHoleLv = goutil.findChildTextComponent(self._mainGo, "unlock/txtHoleLv")
	self._imgSelectGo = goutil.findChild(self._mainGo, "imgSelect")
	self._imgGuang = goutil.findChild(self._mainGo, "imgGuang")
	self._timingLocking = goutil.findChild(self._mainGo, "locking")
	self._statusGo = {
		goutil.findChild(self._mainGo, "unlock"),
		goutil.findChild(self._mainGo, "lock"),
		goutil.findChild(self._mainGo, "imgNoCalibration"),
		goutil.findChild(self._mainGo, "unlock"),
		goutil.findChild(self._mainGo, "imgSeal"),
		goutil.findChild(self._mainGo, "imgQuestion")
	}
	self._enhanceAniGo = {
		goutil.findChild(self._mainGo, "vfx04_loop02"),
		goutil.findChild(self._mainGo, "vfx04_loop01")
	}
	self._enhanceRollAniGo = {
		goutil.findChild(self._mainGo, "vfx01"),
		goutil.findChild(self._mainGo, "vfx02"),
		goutil.findChild(self._mainGo, "vfx03")
	}

	for _, go in ipairs(self._enhanceAniGo) do
		goutil.setActive(go, false)
	end

	for _, go in ipairs(self._enhanceRollAniGo) do
		goutil.setActive(go, false)
	end

	self._imgSelectGo:SetActive(false)

	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "click"))

	self:_bindEvents()

	self._defaultHoleColor = self._imgHoleIcon.color
end

function M:getIconTransPos()
	return self._imgHoleIcon.transform.position
end

function M:setNoCalibrationIcon(isModelShow)
	local NoCalibrationGo = self._statusGo[EquipEnum.HoleStatus.NoCalibration]

	if NoCalibrationGo then
		local modelIcon = goutil.findChild(NoCalibrationGo, "imgGuang_2")
		local normalIcon = goutil.findChild(NoCalibrationGo, "imgDi2")

		if modelIcon then
			goutil.setActive(modelIcon, isModelShow)
			goutil.setActive(normalIcon, not isModelShow)
		else
			local detailIcon = goutil.findChild(NoCalibrationGo, "detailAdd")
			local HoleIcon = goutil.findChild(NoCalibrationGo, "holeAdd")

			goutil.setActive(detailIcon, isModelShow)
			goutil.setActive(HoleIcon, not isModelShow)
		end
	end
end

function M:setTimingLockingShow(isShow)
	goutil.setActive(self._timingLocking, false)
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()

	self._callback = nil
end

function M:_onClickBtnClick()
	if self._callback then
		self._callback()
	end
end

function M:closeEnhanceAni()
	goutil.setActive(self._enhanceAniGo[2], false)
	goutil.setActive(self._enhanceAniGo[1], false)
end

function M:playEnhanceAni(enhanceNum)
	if enhanceNum > 1 and enhanceNum < 4 then
		goutil.setActive(self._enhanceAniGo[2], true)
	elseif enhanceNum == 4 then
		goutil.setActive(self._enhanceAniGo[1], true)
	end
end

function M:playeEnhanceRollAni(enhanceNum)
	for _, go in ipairs(self._enhanceRollAniGo) do
		goutil.setActive(go, false)
	end

	if enhanceNum == 2 then
		goutil.setActive(self._enhanceRollAniGo[1], true)
	elseif enhanceNum == 3 then
		goutil.setActive(self._enhanceRollAniGo[2], true)
	elseif enhanceNum == 4 then
		goutil.setActive(self._enhanceRollAniGo[3], true)
	end
end

function M:setData(data)
	if not self._mainGo.activeSelf then
		return
	end

	if data and data:getIsFackAttr() then
		self:setStatus(EquipEnum.HoleStatus.Unknown)

		return
	end

	if data then
		local iconName = string.format("equip_hole_0%d", data:getEnhanceType())

		IconLoader.setSprite(self._imgHoleIcon, IconType.Skinlib, iconName)
		self:setStatus(EquipEnum.HoleStatus.Unlock)

		if data:isEnhanced() then
			self._imgHoleIcon.color = Astral.ColorUtil.ParseColor("#FFFFFF")

			getres("materials/comm/ui_text_huiguang2.mat", function(res)
				if res.IsSuccess then
					res:Retain()

					local mat = goutil.clone(res:GetMainAsset())

					self._imgHoleIcon.material = mat
				end
			end, nil)
		else
			self._imgHoleIcon.color = self._defaultHoleColor
			self._imgHoleIcon.material = nil
		end
	end
end

function M:showGuang(show)
	goutil.setActive(self._imgGuang, show)
end

function M:setClickCallback(callback)
	self._callback = callback
end

function M:setSelectGoVisible(visible)
	self._imgSelectGo:SetActive(visible)
end

function M:setAllHide()
	for i = 1, #self._statusGo do
		goutil.setActive(self._statusGo[i], false)
	end
end

function M:setVisibleOnTipsUIByStatus(status)
	local visible = status == EquipEnum.HoleStatus.Unknown or status == EquipEnum.HoleStatus.Unlock or status == EquipEnum.HoleStatus.Unalterable or status == EquipEnum.HoleStatus.NoCalibration

	goutil.setActive(self._mainGo, visible)

	if visible then
		self:setAllHide()
		goutil.setActive(self._statusGo[status], true)
	end
end

function M:setStatus(status)
	self:setAllHide()
	goutil.setActive(self._statusGo[status], true)
end

function M:setVisible(visible)
	goutil.setActive(self._mainGo, visible)
end

function M:setPos(x, y)
	TransformUtils.SetLocalPosition(self._transform, x, y, 0)
end

function M:setGoName(name)
	self._mainGo.name = name
end

return M
