local config = require("Vue.reactivity.config")
local __DEV__ = config.__DEV__
local warn = error

local function sameNode(a, b)
  return a.key == b.key
end

local function checkDuplicateKeys(children)
  local seenKeys = {}
  for i = 1, #children do
    local vnode = children[i]
    local key = vnode.key
    if key then
      if seenKeys[key] then
        warn("Duplicate keys detected: {" .. tostring(key) .. "}. This may cause an update error.")
      else
        seenKeys[key] = true
      end
    end
  end
end

local function findIdxInOld(node, oldCh, start, endi)
  for i = start, endi do
    local c = oldCh[i]
    if c and sameNode(node, c) then
      return i
    end
  end
end

local function createKeyToOldIdx(children, beginIdx, endIdx)
  local key
  local map = {}
  for i = beginIdx, endIdx do
    key = children[i].key
    if key then
      map[key] = i
    end
  end
  return map
end

local _, _
local NodeOps = {}

function NodeOps.createElement(vnode)
end

function NodeOps.patchVNode(oldVnode, vnode)
end

function NodeOps.insertBefore(parentNode, newNode, referenceNode)
end

function NodeOps.appendChild(parentNode, newNode)
end

function NodeOps.removeChild(parentNode, child)
end

function NodeOps.nextSibling(parentNode, node)
end

local function patchVnode(oldVnode, vnode, ownerArray, index, nodeOps)
  if oldVnode == vnode then
    return
  end
  ownerArray[index] = vnode
  local elm = oldVnode.elm
  vnode.elm = elm
  nodeOps.patchVNode(oldVnode, vnode)
end

local function insert(parent, elm, ref, nodeOps)
  if parent then
    if ref then
      nodeOps.insertBefore(parent, elm, ref)
    else
      nodeOps.appendChild(parent, elm)
    end
  end
end

local function createElm(vnode, parentElm, refElm, nested, ownerArray, index, nodeOps)
  if vnode.elm then
    ownerArray[index] = vnode
  end
  vnode.elm = nodeOps.createElement(vnode)
  insert(parentElm, vnode.elm, refElm, nodeOps)
end

local function addVnodes(parentElm, refElm, vnodes, startIdx, endIdx, nodeOps)
  for i = startIdx, endIdx do
    createElm(vnodes[i], parentElm, refElm, false, vnodes, i, nodeOps)
  end
end

local function removeVnodes(parentElm, vnodes, startIdx, endIdx, nodeOps)
  for i = startIdx, endIdx do
    local ch = vnodes[i]
    if ch then
      nodeOps.removeChild(parentElm, ch.elm)
    end
  end
end

local function updateChildren(parentElm, oldCh, newCh, nodeOps)
  local oldStartIdx = 1
  local newStartIdx = 1
  local oldEndIdx = #oldCh
  local oldStartVnode = oldCh[1]
  local oldEndVnode = oldCh[oldEndIdx]
  local newEndIdx = #newCh
  local newStartVnode = newCh[1]
  local newEndVnode = newCh[newEndIdx]
  local oldKeyToIdx, idxInOld, vnodeToMove, refElm
  local canMove = true
  if __DEV__ then
    checkDuplicateKeys(newCh)
  end
  while oldStartIdx <= oldEndIdx and newStartIdx <= newEndIdx do
    if nil == oldStartVnode then
      oldStartIdx = oldStartIdx + 1
      oldStartVnode = oldCh[oldStartIdx]
    elseif nil == oldEndVnode then
      oldEndIdx = oldEndIdx - 1
      oldEndVnode = oldCh[oldEndIdx]
    elseif sameNode(oldStartVnode, newStartVnode) then
      patchVnode(oldStartVnode, newStartVnode, newCh, newStartIdx, nodeOps)
      oldStartIdx = oldStartIdx + 1
      oldStartVnode = oldCh[oldStartIdx]
      newStartIdx = newStartIdx + 1
      newStartVnode = newCh[newStartIdx]
    elseif sameNode(oldEndVnode, newEndVnode) then
      patchVnode(oldEndVnode, newEndVnode, newCh, newEndIdx, nodeOps)
      oldEndIdx = oldEndIdx - 1
      oldEndVnode = oldCh[oldEndIdx]
      newEndIdx = newEndIdx - 1
      newEndVnode = newCh[newEndIdx]
    elseif sameNode(oldStartVnode, newEndVnode) then
      patchVnode(oldStartVnode, newEndVnode, newCh, newEndIdx, nodeOps)
      if canMove then
        nodeOps.insertBefore(parentElm, oldStartVnode.elm, nodeOps.nextSibling(parentElm, oldEndVnode.elm))
      end
      oldStartIdx = oldStartIdx + 1
      oldStartVnode = oldCh[oldStartIdx]
      newEndIdx = newEndIdx - 1
      newEndVnode = newCh[newEndIdx]
    elseif sameNode(oldEndVnode, newStartVnode) then
      patchVnode(oldEndVnode, newStartVnode, newCh, newStartIdx, nodeOps)
      if canMove then
        nodeOps.insertBefore(parentElm, oldEndVnode.elm, oldStartVnode.elm)
      end
      oldEndIdx = oldEndIdx - 1
      oldEndVnode = oldCh[oldEndIdx]
      newStartIdx = newStartIdx + 1
      newStartVnode = newCh[newStartIdx]
    else
      if nil == oldKeyToIdx then
        oldKeyToIdx = createKeyToOldIdx(oldCh, oldStartIdx, oldEndIdx)
      end
      idxInOld = newStartVnode.key and oldKeyToIdx[newStartVnode.key] or findIdxInOld(newStartVnode, oldCh, oldStartIdx, oldEndIdx)
      if nil == idxInOld then
        createElm(newStartVnode, parentElm, oldStartVnode.elm, false, newCh, newStartIdx, nodeOps)
      else
        vnodeToMove = oldCh[idxInOld]
        if sameNode(vnodeToMove, newStartVnode) then
          patchVnode(vnodeToMove, newStartVnode, newCh, newStartIdx, nodeOps)
          oldCh[idxInOld] = nil
          if canMove then
            nodeOps.insertBefore(parentElm, vnodeToMove.elm, oldStartVnode.elm)
          end
        else
          createElm(newStartVnode, parentElm, oldStartVnode.elm, false, newCh, newStartIdx, nodeOps)
        end
      end
      newStartIdx = newStartIdx + 1
      newStartVnode = newCh[newStartIdx]
    end
  end
  if oldStartIdx > oldEndIdx then
    refElm = newCh[newEndIdx + 1]
    refElm = refElm and refElm.elm
    addVnodes(parentElm, refElm, newCh, newStartIdx, newEndIdx, nodeOps)
  elseif newEndIdx < newStartIdx then
    removeVnodes(parentElm, oldCh, oldStartIdx, oldEndIdx, nodeOps)
  end
end

return {updateChildren = updateChildren}
