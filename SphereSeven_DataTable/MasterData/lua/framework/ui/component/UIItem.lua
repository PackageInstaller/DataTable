--[[
    以 _item 为例
local _item = UIItemClass(parent) -- 传一个父节点
self.item.SetData(10001, 1)
self.item.SetClickCallback(function() print("click") end)
在关闭时调用 
self.item.OnDestroy()
--]] 

--- 1. 判断gameObject是否为空. 如果为空, 就在父节点下 实例化一个ItemPrefab. 如果不为空, 则忽略parent参数, 直接对gameObject进行操作
---@param parent UnityEngine.GameObject @ 父节点
---@param gameObject UnityEngine.GameObject @ 如果有传入gameObject则不会从对象池中获取
local function UIItemClass(parent, gameObject)
    ---@class UIItemClass
    local self = {}

    local _object
    local _path

    local _clickable
    local _clickCallBack

    local _num
    local _nameText
    local _icon
    local _itemBg
    local _hint

    local _count
    local _templateId

    local _rawColor

    local _isShow
    local _isBag

    local function clickCallBack(self)
        if not _clickable then
            return
        end
        if _clickCallBack == nil then
            local showData = {}
            showData.showType = ShowType.Item
            showData.tempId = _templateId
            UIUtil.OpenThingsDetailWindow(showData, _isBag)
        else
            _clickCallBack()
        end
    end

    local function _init()
        if gameObject ~= nil then
            _object = gameObject
        else
            local prefabName = "ItemPrefab"
            _path = HomeSceneItemPath.."/".. prefabName ..".prefab"
            _object = GameObjectPool:GetInstance():CoGetGameObjectAsync(_path)
            if parent ~= nil then
                _object.transform:SetParent(parent.transform)
            else
                _object.transform:SetParent(nil)
            end
            _object.transform.localScale = Vector3.one
            _object.transform.localPosition = Vector3.zero
        end
    
        local rc = _object:GetComponent("ReferenceCollector")
        _num = LangUtil.BindText(rc:GetObject("Num"), FontType.All_Number)
        _nameText = LangUtil.BindText(rc:GetObject("NameText"))
        _icon = rc:GetObject("Icon"):GetComponent("Image")
        _itemBg = rc:GetObject("ItemBg"):GetComponent("Image")

        _hint = rc:GetObject("Hint")
        if not IsNull(_hint) then
            _hint:SetActive(false)
        end
        _clickCallBack = nil
        _clickable = true
        _isBag = false
        UIUtil.AddBtnEvent(_object, function()
            clickCallBack(self)
        end)

        _rawColor = _num.color
        self.show()
    end

    function self.SetData(templateId, count, color)
        if count ~= nil and count ~= 0 then
            _num.gameObject:SetActive(true)
            _num.text = count
        else
            _num.gameObject:SetActive(false)
        end
    
        _templateId = templateId
        _count = count
        local zItem = Z_Item[templateId]
        _nameText.text = zItem.Name
    
        coroutine.start(function()
            UIUtil.SetSprite(_icon, AtlasConfig.Item, GetItemIcon(zItem))
            UIUtil.SetSprite(_itemBg,AtlasConfig.ItemBg, zItem.IconBg .. ".png")
        end)

        if color ~= nil then
            _num.color = color
        else
            _num.color = _rawColor
        end
    end
    
    function self.SetClickCallback(callback)
        _clickCallBack = callback
    end

    function self.SetClickAble(able)
        _clickable = able
    end

    -- 销毁 需要外面手动调用
    function self.OnDestroy()
        if gameObject ~= nil then
            GameObjectPool:GetInstance():RecycleGameObject(_path, _object)
        end
    end

    function self.show()
        _isShow = true
        _object:SetActive(true)
    end

    function self.hide()
        _isShow = false
        _object:SetActive(false)
    end

    function self.showName()
        _nameText.gameObject:SetActive(true)
    end

    function self.hideName()
        _nameText.gameObject:SetActive(false)
    end

    function self.SetIsBag(isBag)
        _isBag = isBag
    end

    _init()

    return self
end

return UIItemClass