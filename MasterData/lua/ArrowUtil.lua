local this = {}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

--- 初始化
---@param father 父物体
---@param child 子物体
---@param arrowLT 左或上箭头
---@param arrowRD 右或下箭头
---@param isVer 是否垂直
function this:Init(father,child,arrowLT,arrowRD,isVer)
    self.father = father
    self.child = child
    self.arrowLT = arrowLT 
    self.arrowRD = arrowRD
    CSAPI.SetGOActive(self.arrowLT,false)
    CSAPI.SetGOActive(self.arrowRD,false)
    self.fatherLen = 0
    self.childLen = 0
    self.childScale = 1
    self.currPos = 0
    self.lastPos = -1
    self.isVer = isVer ~= nil
    self:RefreshLen()
end

--刷新长度
function this:RefreshLen()
    if self.father then
        self.fatherLen = self.isVer and CSAPI.GetRealRTSize(self.father)[1] or CSAPI.GetRealRTSize(self.father)[0]
    end
    if self.child then
        self.childLen = self.isVer and CSAPI.GetRealRTSize(self.child)[1] or CSAPI.GetRealRTSize(self.child)[0]
        if self.isVer then
            self.x,self.childScale = CSAPI.GetScale()
        else
            self.childScale = CSAPI.GetScale()
        end
    end
end

function this:Update()
    if self.childLen * self.childScale > self.fatherLen then
        if not IsNil(self.child) then
            if self.isVer then
               self.x,self.currPos = CSAPI.GetAnchor(self.child)
            else
                self.currPos = CSAPI.GetAnchor(self.child)
            end
        end
        if math.abs(self.currPos - self.lastPos) > 0.01 then
            if self.isVer then
                CSAPI.SetGOActive(self.arrowLT,self.currPos > 0.1)
                CSAPI.SetGOActive(self.arrowRD,self.currPos < (self.childLen * self.childScale  - self.fatherLen) - 0.1) 
            else
                CSAPI.SetGOActive(self.arrowLT,self.currPos < -0.1)
                CSAPI.SetGOActive(self.arrowRD,self.currPos > -(self.childLen * self.childScale - self.fatherLen) + 0.1)    
            end
            self.lastPos = self.currPos
        end
    end
end

return this 