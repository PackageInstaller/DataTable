---@class LongPressUIEffect
---@field gameObject UnityEngine.GameObject
---@field filledImg UnityEngine.UI.Image
---@field dirTrs UnityEngine.Transform
---@field handle function
---@field startTime number 开始时间
---@field delayShowTime number 延时显示时间
---@field maxTime number 长按最大时and 
---@field maxProgress number 最大进度 超过这个进度 直接置进度为1 因为有个进度条头在 so... 
local LongPressUIEffect = class("LongPressUIEffect")
function LongPressUIEffect:ctor(gameObject)
    self.gameObject = gameObject
    self.isActive = nil
    local trs = gameObject.transform
    self.filledImg = trs:Find("filledImg"):GetComponent("Image")
    self.dirTrs = trs:Find("dirTrs")
    self.handle = nil
end

---@param delayShowTime number 延时显示时间
---@param maxTime number 最大显示时间 
---@param maxProgress number 最大进度 ps实际进度= 1 - ((1 - p) * 2)
function LongPressUIEffect:Start(delayShowTime, maxTime, maxProgress)
    self.startTime = Time.time
    self.delayShowTime = delayShowTime
    self.maxTime = maxTime
    self.maxProgress = maxProgress or 1

    if not self.handle then
		self.handle = UpdateBeat:CreateListener(self.Update, self)
	end
    UpdateBeat:AddListener(self.handle)
end

function LongPressUIEffect:Update()
    if self.startTime == nil then    
        return
    end

    local elapsedTime = Time.time - self.startTime
    if elapsedTime < self.delayShowTime then
        return
    end
    if not self.isActive then
        self.isActive = true
        self.gameObject:SetActive(true)    
    end
    local showTime = (self.maxTime - self.delayShowTime)
    local p = elapsedTime / self.maxTime
    local rp = p
    local s = self.delayShowTime / self.maxTime
    p = (p - s) / (1 - s)
    
    local headProgress = 1 - self.maxProgress
    local progressLen = 1 - 2 * headProgress

    local s =  progressLen / self.maxProgress 
    p = p * s
    p =  headProgress + p * progressLen
    self.filledImg.fillAmount = p
    self.dirTrs.localEulerAngles = Vector3.New(0, 0, -p * 360)

    if rp >= 1 then
        self:PlayFinished()
    end
end


function LongPressUIEffect:PlayFinished()

    self.isActive = false
    self.gameObject:SetActive(false)
    self.startTime = nil
    if self.handle then
		UpdateBeat:RemoveListener(self.handle)	
	end
end

function LongPressUIEffect:Hide()
    self:PlayFinished()
end

function LongPressUIEffect:OnDestroy()
    if self.handle then
		UpdateBeat:RemoveListener(self.handle)	
	end
end

return LongPressUIEffect