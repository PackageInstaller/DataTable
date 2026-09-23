function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    CSAPI.SetText(txtName, _data.sName)
end

function Select(b)
    CSAPI.SetGOActive(normal, not b)
    CSAPI.SetGOActive(sel, b)
end

function OnClick()
    cb(this)
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    clickNode = nil;
    txtName = nil;
    view = nil;
end
----#End#----
