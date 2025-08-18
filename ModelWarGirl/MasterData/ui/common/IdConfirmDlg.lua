-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\IdConfirmDlg.lua

local strClassName = "IdConfirmDlg"
local IdConfirmDlg = Class(strClassName, UIControls.Window)

function IdConfirmDlg:ctor()
	self:initUI()
end

function IdConfirmDlg:initUI()
	self.textName = UIControls.Input(self, "Bg/TextName/InputField")
	self.textId = UIControls.Input(self, "Bg/TextID/InputField")
	self.btnCancel = UIControls.Button(self, "Bg/BtnDeny")

	self.btnCancel:addEventClick(self.onClickCancel)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickConfirm)
end

function IdConfirmDlg:onClickCancel()
	self:setVisible(false)
end

local wi = {
	7,
	9,
	10,
	5,
	8,
	4,
	2,
	1,
	6,
	3,
	7,
	9,
	10,
	5,
	8,
	4,
	2,
	1
}
local vi = {
	"1",
	"0",
	"X",
	"9",
	"8",
	"7",
	"6",
	"5",
	"4",
	"3",
	"2"
}

local function isBirthDate(date)
	local year = tonumber(date:sub(1, 4))
	local month = tonumber(date:sub(5, 6))
	local day = tonumber(date:sub(7, 8))

	if year < 1900 or year > 2100 or month > 12 or month < 1 then
		return false
	end

	local month_days = {
		31,
		28,
		31,
		30,
		31,
		30,
		31,
		31,
		30,
		31,
		30,
		31
	}
	local bLeapYear = year % 4 == 0 and year % 100 ~= 0 or year % 400 == 0

	if bLeapYear then
		month_days[2] = 29
	end

	if day > month_days[month] or day < 1 then
		return false
	end

	return true
end

local function isAllNumberOrWithXInEnd(str)
	local ret = str:match("%d+X?")

	return ret == str
end

local function checkSum(idcard)
	local nums = {}
	local _idcard = idcard:sub(1, 17)

	for ch in _idcard:gmatch(".") do
		table.insert(nums, tonumber(ch))
	end

	local sum = 0

	for i, k in ipairs(nums) do
		sum = sum + k * wi[i]
	end

	return vi[sum % 11 + 1] == idcard:sub(18, 18)
end

local err_success = 0
local err_length = 1
local err_province = 2
local err_birth_date = 3
local err_code_sum = 4
local err_unknow_charactor = 5

local function verifyIDCard(idcard)
	if string.len(idcard) ~= 18 then
		return err_length
	end

	if not isAllNumberOrWithXInEnd(idcard) then
		return err_unknow_charactor
	end

	local nProvince = tonumber(idcard:sub(1, 2))

	if nProvince < 11 or nProvince > 90 then
		return err_province
	end

	if not isBirthDate(idcard:sub(7, 14)) then
		return err_birth_date
	end

	if not checkSum(idcard) then
		return err_code_sum
	end

	return err_success
end

function IdConfirmDlg:onClickConfirm()
	local name = self.textName:getText()
	local idNum = self.textId:getText()

	if #name < 1 or #name > 26 then
		MsgManager.notice(Lang.get(30213))

		return
	end

	local succ = verifyIDCard(idNum)

	if succ == err_length then
		MsgManager.notice(Lang.get(30214))

		return
	elseif succ == err_unknow_charactor then
		MsgManager.notice(Lang.get(30215))

		return
	elseif succ ~= err_success then
		MsgManager.notice(Lang.get(30216))

		return
	end

	RPC.roleMiscIDCard(idNum)
	self:setVisible(false)
	MsgManager.notice(Lang.get(30217))
end

return IdConfirmDlg
