using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using LuaInterface;

namespace LuaFramework {
    public class PanelManager : Manager {
        private Transform layer1;

        private Transform layer2;

        Transform Layer1 {
            get {
                if (layer1 == null) {
                    GameObject go = GameObject.FindWithTag("Layer1");
                    if (go != null) layer1 = go.transform;
                }
                return layer1;
            }
        }

        Transform Layer2{
            get
            {
                if (layer2 == null)
                {
                    GameObject go = GameObject.FindWithTag("Layer2");
                    if (go != null) layer2 = go.transform;
                }
                return layer2;
            }
        }

        /// <summary>
        /// ������壬������Դ������
        /// </summary>
        /// <param name="type"></param>
        public void CreatePanel(string name, LuaFunction func = null) {
            string assetName = name + "Panel";
            string abName = name.ToLower() + AppConst.ExtName;
            if (Layer1.Find(name) != null) return;
            if (Layer2.Find(name) != null) return;

#if ASYNC_MODE
            ResManager.LoadPrefab(abName, assetName, delegate(UnityEngine.Object[] objs) {
                if (objs.Length == 0) return;
                GameObject prefab = objs[0] as GameObject;
                if (prefab == null) return;

                GameObject go = Instantiate(prefab) as GameObject;
                go.name = assetName;
                go.layer = LayerMask.NameToLayer("Default");
                if (assetName != "TipsPanel")
                {
                    go.transform.SetParent(Layer1);
                }
                else
                {
                    go.transform.SetParent(Layer2);
                }
                go.transform.localScale = Vector3.one;
                go.transform.localPosition = Vector3.zero;
                go.AddComponent<LuaBehaviour>();

                if (func != null) func.Call(go);
                Debug.LogWarning("CreatePanel::>> " + name + " " + prefab);
            });
#else
            GameObject prefab = ResManager.LoadAsset<GameObject>(name, assetName);
            if (prefab == null) return;

            GameObject go = Instantiate(prefab) as GameObject;
            go.name = assetName;
            go.layer = LayerMask.NameToLayer("Default");
            go.transform.SetParent(Parent);
            go.transform.localScale = Vector3.one;
            go.transform.localPosition = Vector3.zero;
            go.AddComponent<LuaBehaviour>();

            if (func != null) func.Call(go);
            Debug.LogWarning("CreatePanel::>> " + name + " " + prefab);
#endif
        }

        /// <summary>
        /// �ر����
        /// </summary>
        /// <param name="name"></param>
        public void ClosePanel(string name) {
            var panelName = name + "Panel";
            var panelObj = Layer1.Find(panelName);
            if (panelObj != null)
            {
                Destroy(panelObj.gameObject);
            }
            var panelObj2 = Layer2.Find(panelName);
            if (panelObj2 != null)
            {
                Destroy(panelObj2.gameObject);
            }
        }
    }
}