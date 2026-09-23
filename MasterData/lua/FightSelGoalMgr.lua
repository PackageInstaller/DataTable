local this = {};

function this:UpdateSelGoals(characters)
    self:Clean();

    local index = 1;
    if(characters)then
        for id,character in pairs(characters)do
            self.items = self.items or {};

            local item = self.items[index];
            local isEnemy = character.IsEnemy();

            if(item == nil)then
                item = self:CreateItem(isEnemy);
                self.items[index] = item;
            end

            item.Set(character);
            index = index + 1;
        end    
    end   
end

function this:UpdateSelGrids(gridDatas,dontClear)
    if(not dontClear)then
        self:Clean();
    end

    
    if(gridDatas)then
        self.items = self.items or {};
        local index = #self.items + 1;
        for _,gridData in pairs(gridDatas)do
            
            local item = self.items[index];
            if(item == nil)then
                item = self:CreateItem(TeamUtil:IsEnemy(gridData.teamId));
                self.items[index] = item;
            end
            item.SetGrid(gridData);
            index = index + 1;
        end    
    end
end



function this:Clean()
     if(self.items)then
        local count = #self.items;
        for i = 1,count do
            local item = self.items[i];
            if(item)then
                self.items[i] = nil;
                item.Set(nil);
            end
        end

        self.items = nil;
    end
end

function this:CreateItem(isEnemy)
    --LogError("������������������������");

    local go = CSAPI.CreateGO("FightSelGridEff" .. (isEnemy and "_Red" or ""));
    local lua = ComUtil.GetLuaTable(go);
    return lua;
end

function this:Preload()
    local arr = {};

    local len = 14;
    for i = 1,len do
        local item = self:CreateItem(i >= len * 0.5);
        table.insert(arr,item);
    end

    for _,item in ipairs(arr) do
        item.Set(nil);
    end
end

return this;