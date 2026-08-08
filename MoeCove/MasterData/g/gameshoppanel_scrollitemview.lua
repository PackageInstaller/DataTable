





---@class ScrollItemView
local ScrollItemView = class("GameShopPanel_ScrollItemView")


local function getSignValue(n)
    if type(n) ~= "number" then
        error("输入必须是数字")
    end
    if n > 0 then
        return 1
    elseif n < 0 then
        return -1
    else
        return 0
    end
end

---@class ItemObj:UIObj
---@field ui ScrollItemView
---@field data integer
local ItemObj = class("ScrollItemView_ItemObj")
function ItemObj:ctor(gameObject, ui)
    self.gameObject = gameObject
    self.ui = ui
    self.transform = gameObject.transform
end

function ItemObj:SetData(data)
    self.data = data
    if self.ui.onValueChangeFun ~= nil then
        self.ui.onValueChangeFun(self.gameObject, data)
    end
end

function ItemObj:SetPos(val)
    self.posVal = val
    self.transform.anchoredPosition = Vector2.New(val, 0)
end

function ItemObj:GetPos(val)
    return self.posVal
end

function ItemObj:Create(gameObject, ui)
    local uiObj = self:new(gameObject, ui)
    return uiObj
end

---@param gameObject UnityEngine.GameObject
function ScrollItemView:ctor(gameObject, onValueChangeFun)
    self.gameObject = gameObject
    local trs = gameObject.transform
    self.content = trs:Find("content")
    local img = trs:Find("content/leftImg"):GetComponent(TypeInfo.Image)
    local text = img.transform:Find("valText"):GetComponent(TypeInfo.TextMeshProUGUI)
    local itemObj = trs:Find("content/leftImg").gameObject
    ---@type ItemObj
    self.leftObj = ItemObj:Create(itemObj, self)

    local itemObj = trs:Find("content/rightImg").gameObject
    ---@type ItemObj
    self.rightObj = ItemObj:Create(itemObj, self)

    local el = EventTriggerListener.Get(gameObject)
    el.onBeginDrag  = BindSelf(self, self.OnBeginDrag)
    el.onDrag  = BindSelf(self, self.OnDrag)
    el.onEndDrag  = BindSelf(self, self.OnEndDrag)


    local el = EventTriggerListener.Get(self.rightObj.gameObject)
    el.onBeginDrag  = BindSelf(self, self.OnBeginDrag)
    el.onDrag  = BindSelf(self, self.OnDrag)
    el.onEndDrag  = BindSelf(self, self.OnEndDrag)


    local el = EventTriggerListener.Get(self.leftObj.gameObject)
    el.onBeginDrag  = BindSelf(self, self.OnBeginDrag)
    el.onDrag  = BindSelf(self, self.OnDrag)
    el.onEndDrag  = BindSelf(self, self.OnEndDrag)

    self.onValueChangeFun = onValueChangeFun

    self.pageTogglePrefab = trs:Find("pageToggleGroup/pageToggle").gameObject

    self.toggles = {}
    table.insert(self.toggles, self.pageTogglePrefab:GetComponent(TypeInfo.Toggle))

    ---@type integer 当前显示数据index
    self.curIndex = 1
    ---@type integer 数据总数
    self.dataCount = 0
    ---@type number view宽度
    self.viewLen = trs.sizeDelta.x
    ---@type number 开始拖拽位置
    self.beginDragVal = 0
    ---@type number 开始拖拽位置 方向变化后会重置位置
    self.drawVal = 0
    ---@type number 拖拽时间 方向变化后会重置时间
    self.dragTime = Time.time

    ---最小拖拽范围
    self.minDrawLen = 50
    ---拖拽速度
    self.gotoNextSpeed = 50
    ---拖拽方向
    self.drawDir = 0
    ---移动时间
    self.moveTime = 0.5
    ---@type boolean 是否在移动中
    self.isMoveing = false
    self.isDraging = false

    ---@type function
    self.onMoveFinish = nil
end


function ScrollItemView:SetDataCount(dataCount)
    self.dataCount = dataCount
    for i = #self.toggles + 1, dataCount do
        local obj = EngineUtil.Instantiate(self.pageTogglePrefab)
        local tog = obj:GetComponent(TypeInfo.Toggle)
        table.insert(self.toggles, tog)
    end

    for i = dataCount + 1, #self.toggles do
        local tog = self.toggles[i]
        tog.gameObject:SetActive(false)
    end
    self.toggles[1].isOn = true
    self.content.anchoredPosition = Vector2.zero
    self.leftObj:SetPos(0 * self.viewLen)
    self.leftObj:SetData(1)
    self.curIndex = 1
    self.isMoveing = false
    self.beginDragVal = nil
    self.drawVal = 0

    self.rightObj:SetPos(1 * self.viewLen)
    self.rightObj:SetData(2)
end


function ScrollItemView:MoveToNext()
    self.content.anchoredPosition = Vector2.zero
    self.leftObj:SetPos(0)
    self.leftObj:SetData(self.curIndex)

    local nextData = self.curIndex + 1
    if nextData > self.dataCount then
        nextData = 1
    end
    self.rightObj:SetData(nextData)
    self.isMoveing = false
    self.beginDragVal = nil
    self.drawVal = 0
    self.curDragVal = 0
    self.beginDragVal = 0
    self:CenteredDisplayItem(-1)
end

function ScrollItemView:OnItemClick(index)
    if self.isMoveing or self.isDraging then
        return
    end
    if self.onClickFun ~= nil then
        self.onClickFun(index)
    end
    LuaLogger.es("===>>> 点击推荐商品 index:" .. tostring(index))
end

---开始拖拽
---@param obj UnityEngine.GameObject
---@param eventData UnityEngine.EventSystems.PointerEventData
function ScrollItemView:OnBeginDrag(obj, eventData)
    if self.isMoveing then
       return 
    end
    self.beginDragVal = eventData.position.x
end
function ScrollItemView:OnDrag(obj, eventData)
 if self.isMoveing then
       return 
    end
    if self.beginDragVal == nil then
        return
    end
    self.isDraging = true
    self:SetDragVal(eventData.position.x)
end

function ScrollItemView:OnEndDrag(obj, eventData)
    if self.isMoveing then
       return 
    end
    if self.beginDragVal == nil then
        return
    end
    self.isDraging = false

    local drawPx = self.curDragVal - self.beginDragVal

    if math.abs(drawPx) < self.minDrawLen then
        self:CenteredDisplayItem(0)
        return
    end
    self:CenteredDisplayItem(self.drawDir)
end

function ScrollItemView:SetDragVal(val)
    self.curDragVal = val
    local drawPx = self.curDragVal - self.beginDragVal
    if drawPx == 0 then
        return
    end

    local viewDrawPx = drawPx - (self.curIndex - 1) * self.viewLen
    local relayIndex = math.ceil(-viewDrawPx / self.viewLen) - 1

    local leftIndex =  mathx.Repeat(relayIndex, self.dataCount) + 1
    local rightIndex = leftIndex + 1
    if rightIndex > self.dataCount then
        rightIndex = 1
    end

    self.content.anchoredPosition = Vector2.New(viewDrawPx, 0)
    self.leftObj:SetData(leftIndex)
    self.leftObj:SetPos(relayIndex * self.viewLen)
    self.rightObj:SetData(rightIndex)
    self.rightObj:SetPos((relayIndex + 1) * self.viewLen)

    if self.drawDir ~= getSignValue(drawPx) then
        self.dragTime = Time.time
        self.drawVal = val
        self.drawDir = getSignValue(drawPx)
    end
end


---居中显示元素
---@param val integer 0表示谁占的多显示谁 -1表示显示左边 1表示显示右边
function ScrollItemView:CenteredDisplayItem(val)
    local drawPx = self.curDragVal - self.beginDragVal
    local centerIndex  = 0
    local cenObj = nil
    if val == 0 then
        local lcv = drawPx - (drawPx + self.leftObj:GetPos())
        local rcv = drawPx - (drawPx + self.rightObj:GetPos())
        if math.abs(lcv) < math.abs(rcv) then
            cenObj = self.leftObj
        else
            cenObj = self.rightObj
        end
    elseif val < 0 then
        cenObj = self.rightObj
    else
        cenObj = self.leftObj
    end
    centerIndex = cenObj.data
    local cv = drawPx - (drawPx + cenObj:GetPos())

    self.isMoveing = true
    self.content:DOAnchorPos(Vector2.New(cv, 0), 0.2):OnComplete(function(a, b, c)
        self.content.anchoredPosition = Vector2.zero
        self.leftObj:SetPos(0)
        self.leftObj:SetData(centerIndex)
        local nextIndex = centerIndex + 1
        if nextIndex > self.dataCount then
            nextIndex = 1
        end
        self.rightObj:SetData(nextIndex)
        self.rightObj:SetPos(self.viewLen)
        self.curIndex = centerIndex
        self.isMoveing = false
        self.beginDragVal = nil
        self.drawVal = 0
        if self.onMoveFinish then
            self.onMoveFinish()
        end
    end)
    self.toggles[centerIndex].isOn = true
end
return ScrollItemView
