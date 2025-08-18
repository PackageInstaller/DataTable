-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroCardListSetDlg.lua

local strClassName = "HeroCardListSetDlg"
local HeroCardListSetDlg = Class(strClassName, UIControls.Window)

function HeroCardListSetDlg:ctor()
	self:initUI()
end

function HeroCardListSetDlg:initUI()
	if CurAvatar then
		self.currentEntity = CurAvatar
	end

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnReset = UIControls.Button(self, "BgPanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.toggleGroup1 = {}

	for i = 1, 5 do
		local toggle = UIControls.Toggle(self, "BgPanel/ChooseTypePanel1/Option" .. i)

		table.insert(self.toggleGroup1, toggle)
	end

	self.toggleGroup2 = {}

	for i = 1, 3 do
		local toggle = UIControls.Toggle(self, "BgPanel/ChooseTypePanel2/Option" .. i)

		table.insert(self.toggleGroup2, toggle)
	end

	self.toggleGroup3 = {}

	for i = 1, 5 do
		local toggle = UIControls.Toggle(self, "BgPanel/ChooseTypePanel3/Option" .. i)

		table.insert(self.toggleGroup3, toggle)
	end

	self.totalToggle = {}

	for i = 1, 3 do
		table.insert(self.totalToggle, self["toggleGroup" .. i])
	end
end

function HeroCardListSetDlg:onBtnResetClick()
	for i, v in ipairs(self.totalToggle) do
		for ii, vv in ipairs(v) do
			v[ii]:setOn(false)
		end
	end
end

local TOGGLE_GROUP_PROPERTY_MAP = {
	"quality",
	"camp",
	"career"
}

function HeroCardListSetDlg:setSelectCallback(filterCallBack)
	self.filterCallBack = filterCallBack
end

function HeroCardListSetDlg:setFilterConfig(filterConfig)
	if filterConfig then
		self:onBtnResetClick()

		for i, v in ipairs(filterConfig) do
			for ii, vv in ipairs(v) do
				self.totalToggle[i][vv]:setOn(true)
			end
		end
	end
end

function HeroCardListSetDlg:onBtnConfirmClick()
	self.toggleGroupTypeFilter = {}

	for i = 1, 3 do
		self["toggleGroupTypeFilter" .. i] = {}

		for ii, v in ipairs(self["toggleGroup" .. i]) do
			if v:isOn() == true then
				table.insert(self["toggleGroupTypeFilter" .. i], ii)
			end
		end

		table.insert(self.toggleGroupTypeFilter, self["toggleGroupTypeFilter" .. i])
	end

	local function checkFilterFunc(hero)
		local typeCertList = {}

		for i, v in ipairs(self.toggleGroupTypeFilter) do
			if #v > 0 then
				for s, vz in ipairs(v) do
					if hero[TOGGLE_GROUP_PROPERTY_MAP[i]] == vz then
						typeCertList[i] = true
					end
				end

				if not typeCertList[i] then
					typeCertList[i] = false
				end
			else
				typeCertList[i] = true
			end
		end

		local isCertPass = true

		for i, v in ipairs(typeCertList) do
			if v == false then
				isCertPass = false
			end
		end

		return isCertPass
	end

	if self.filterCallBack then
		self.filterCallBack(checkFilterFunc, true, self.toggleGroupTypeFilter)
	end
end

function HeroCardListSetDlg:onCloseClick()
	self:setVisible(false)
end

return HeroCardListSetDlg
