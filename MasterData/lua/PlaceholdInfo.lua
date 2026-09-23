--复杂占位信息

local this = {};

function this.New(rowIndex,colIndex,gridTeamId,placeholderList)
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	 
    
    ins:Init(rowIndex,colIndex,gridTeamId,placeholderList);  
	return ins;
end

this.attacher = nil;

--关联的格子
this.gridList = nil;

--x坐标
this.x = 0;
--y坐标
this.y = 0;

this.sizeX = 0;
this.sizeY = 0;

--第一个排号
this.firstRowIndex = 0;
--第一个列号
this.firstColIndex = 0;

--初始化
--placeholderList：占位索引列表，偶数，示例：[1,1,1,2]，[1,1,2,1]
function this:Init(rowIndex,colIndex,gridTeamId,placeholderList)

    --单占位处理成多占位
    if(placeholderList == nil or #placeholderList == 0)then
        placeholderList = {{1,1}};
    end

    local xMin = 1000;
    local xMax = -1000;
    local yMin = 1000;
    local yMax = -1000;

    self.gridList = {};

    local len = #placeholderList;   

    self.firstRowIndex = rowIndex;
    self.firstColIndex = colIndex;

    for i = 1,len do
        local subRowIndex = rowIndex + placeholderList[i][1] - 1;
        local subColIndex = colIndex + placeholderList[i][2] - 1;

        local subLuaFightGrid = FightGroundMgr:GetGrid(subRowIndex,subColIndex,gridTeamId);
        if(subLuaFightGrid ~= nil)then
            table.insert(self.gridList,subLuaFightGrid);

            local posX = subLuaFightGrid.x;
            local posY = subLuaFightGrid.y;

            xMin = ((xMin > posX) and posX) or xMin;
            xMax = ((xMax < posX) and posX) or xMax;
            yMin = ((yMin > posY) and posY) or yMin;
            yMax = ((yMax < posY) and posY) or yMax;
        end
    end

    self.x = (xMin + xMax) * 0.5;
    self.y = (yMin + yMax) * 0.5;

    local gridSize = FightGroundMgr:GetGridSize();

    self.sizeX = math.abs(xMax - xMin) + gridSize;
    self.sizeY = math.abs(yMax - yMin) + gridSize;
end

--是否能放入
function this:CheckPutIn()
    if(self.gridList == nil)then
        LogError("占位信息不包含任何格子对象！");
        return false;
    end
    for _,luaFightGrid in pairs(self.gridList) do
        local isHold = luaFightGrid.IsHold();
        if(isHold)then
            return false;
        end
    end
    return true;
end

--获取占用者
function this:GetCharacter()
    if(self.attacher ~= nil)then
        return self.attacher.owner;
    end
    return nil;
end

function this:PutIn(targetAttacher)
    if(targetAttacher == nil)then
        LogError("targetAttacher为空");
        return;
    end

    self.attacher = targetAttacher;
    self.attacher:Add(self);
    for _,v in pairs(self.gridList) do
        v.ApplyPutIn(self);
    end
end

function this:PutOut()
    
    if(self.attacher ~= nil)then
        self.attacher:Clean();
    end

    self.attacher = nil;
   
    for _,v in pairs(self.gridList) do
        v.PutOut();
    end
end

return this;