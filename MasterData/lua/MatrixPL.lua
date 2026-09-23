-- pl计算插件
MatrixPL = {}
local this = MatrixPL
function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(cRoleData, face, txtPL, slider, imgSlider,onlyCur)
    self.cRoleData = cRoleData
    self.face = face
    self.txtPL = txtPL
    self.slider = slider
    self.imgSlider = imgSlider
    self.onlyCur = onlyCur
    self.outlineBar = nil
    if (self.slider) then
        self.outlineBar = ComUtil.GetCom(self.slider, "OutlineBar")
    end
    self.plTimer = nil
    if (self.cRoleData) then
        self.plPerTimer = self.cRoleData:GetPerTimer()
        if (self.plPerTimer and self.plPerTimer > 0) then
            self.plTimer = Time.time -- + self.plPerTimer
        end
    end

    self:SetPL()
    self:SetBar()

    self.isInit = true
end

function this:Update()
    if (not self.isInit) then
        return
    end
    if (self.plTimer and Time.time >= self.plTimer) then
        self.plTimer = Time.time + self.plPerTimer
        self:SetPL()
        self:SetBar()
    end
end

function this:SetPL()
    if (self.cRoleData) then
        self.curTv = self.cRoleData:GetCurRealTv()
        if (self.txtPL) then
            local code = self.GetColor(self.curTv)
            local str = ""
            if(self.onlyCur) then 
                str = string.format("<color=#%s>%s</color>", code, self.curTv)
            else 
                str = string.format("<color=#%s>%s</color><color=#929296>/%s</color>", code, self.curTv, 100)
            end 
            CSAPI.SetText(self.txtPL, str)
        end
        local faceName = MatrixMgr:GetFaceName(self.curTv)
        ResUtil.Face:Load(self.face, faceName)
    end
end

function this:SetBar()
    if (self.cRoleData ~= nil and self.outlineBar ~= nil and (self.oldCur == nil or self.oldCur ~= self.curTv)) then
        self.oldCur = self.curTv
        self.outlineBar:SetProgress(self.curTv and self.curTv / 100 or 0)
        if (self.imgSlider) then
			local code = self.GetColor(self.curTv)
            CSAPI.SetTextColorByCode(self.imgSlider, code)
        end
    end
end

function this.GetColor(tv)
    local code = "FFFFFF"
    if (tv <= 10) then
        code = "FF0040"
    elseif (tv <= 50) then
        code = "FFC146"
    end
    return code
end

-- function this:InitTime(b, _tf, _tv, _oldTime, face, txtPL)
-- 	self.isCalTime = false
-- 	self.face = face
-- 	self.txtPL = txtPL
-- 	if(not b) then		
-- 		return
-- 	end
-- 	self.pl_tf = _tf
-- 	self.pl_tv = _tv
-- 	self.pl_oldTime = _oldTime
-- 	self.pl_Timer = Time.time
-- 	if(self.pl_tf and self.pl_tf > 0 and TimeUtil:GetTime() < self.pl_tf) then
-- 		len = 100 - self.pl_tv
-- 		self.isCalTime = true
-- 	else
-- 		self:SetPl(self.pl_tv)
-- 	end
-- end
-- function this:SetPl(num)
-- 	--face
-- 	local faceName = MatrixMgr:GetFaceName(num)
-- 	if(self.faceName == nil or self.faceName ~= faceName) then
-- 		self.faceName = faceName
-- 		ResUtil.Face:Load(self.face, faceName)
-- 	end
-- 	--num
-- 	if(self.oldNum == nil or self.oldNum ~= num) then
-- 		self.oldNum = num
-- 		local code = "FFFFFF"
-- 		if(num >= 100) then
-- 			code = "FF0040"
-- 		elseif(num >= 50) then
-- 			code = "FFC146"
-- 		end
-- 		local str = string.format("<color=#%s>%s</color><color=#929296>/100</color>", code, num)
-- 		CSAPI.SetText(self.txtPL, str)
-- 	end
-- 	if(num >= 100) then
-- 		self.isCalTime = false
-- 	end
-- end
-- function this:Update()
-- 	if(self.isCalTime) then
-- 		if(Time.time > self.pl_Timer) then
-- 			self.pl_Timer = Time.time + 1
-- 			local per =(TimeUtil:GetTime() - self.pl_oldTime) /(self.pl_tf - self.pl_oldTime)
-- 			self:SetPl(self.pl_tv + math.floor(len * per))
-- 		end
-- 	end
-- end
-- function this:GetInfo()
-- 	return self.oldNum, self.faceName, self.isCalTime
-- end
return this
