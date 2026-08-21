local GeneBallCtrl = BaseClass("GeneBallCtrl",UIBaseComponent)
local M = GeneBallCtrl 


function M:SetGeneBallInfo(isActive, name, lv, fill)
    self.m_StarSpace = 0.36
    self.m_StarList = self.m_StarList or {}
    self._view.star.gameObject:SetActive(false)

    if isActive then
        self._view.IconPlane.color = Color.New(225 / 255, 1, 1, 1)
        self._view.BarImage:SetFillAmount(fill)
        self._view.RoleGeneLv.gameObject:SetActive(true)

        local nameStr = ConfigHelper.GetLocalString(name)
        self._view.LvValue.text = nameStr
        self._view.LvValue.gameObject:SetLocalPos(0, 0.48, 0)
        self:SetStar(lv)
    else
        self._view.IconPlane.color = Color.black
        self._view.RoleGeneLv.gameObject:SetActive(false)
    end
end


function M:SetStar(lv)
    local num1, num2 = math.modf(lv / 2)

    local startPos = 0.36 * num1
    if num2 == 0 then
        startPos = startPos + self.m_StarSpace / 2
    else
        startPos = startPos + self.m_StarSpace
    end

    for i=1, lv do
        local item = self.m_StarList[i]

        if not item then
            item = self:CreateStar()
        end

        local posX = startPos * -1 + self.m_StarSpace * i
        item.gameObject:SetLocalPos(posX, 1.1, 0)
        item:SetActive(true)
    end
end


function M:CreateStar()
    local item = self._view.star:Instantiate()
    self.m_StarList[#self.m_StarList + 1] = item
    return self.m_StarList[#self.m_StarList]
end




return GeneBallCtrl