using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mapgenerator : MonoBehaviour
{
    public Texture2D shape;
    public GameObject[] cube;
    public Material[] mat;
    public Color[] color;
    public GameObject[] prop;
    public GameObject Propmaneger;

    // Use this for initialization
    void Start()
    {

        ColorcubeSpawner();
        Propmaneger.gameObject.layer = LayerMask.NameToLayer("prop");
    }

    // Update is called once per frame
    void Update()
    {


        if (Input.GetKeyDown(KeyCode.Space))
        {

            foreach (GameObject eachBlackCube in GameObject.FindGameObjectsWithTag("BlackCube"))
                eachBlackCube.transform.position = new Vector3(eachBlackCube.transform.position.x, -1, eachBlackCube.transform.position.z);
            foreach (Renderer eachBlackCube in GetComponentsInChildren<Renderer>())
            {


            }


        }

    }

    void ColorcubeSpawner()
    {

        Color[] pixels = shape.GetPixels();
        cube = new GameObject[pixels.Length];

        for (int index = 0; index < pixels.Length; index++)
        {
            if (pixels[index] != Color.white)
            {
                cube[index] = GameObject.CreatePrimitive(PrimitiveType.Cube);
                cube[index].transform.position = new Vector3(index % shape.width, 0, index / shape.width);
                cube[index].GetComponent<MeshRenderer>().material.color = pixels[index];

                for (int count = 0; count < color.Length; count++)
                {
                    if (pixels[index] == color[count])
                    {
                        cube[index].tag = "Test" + count;
                        cube[index].name = cube[index].tag;

                        cube[index].GetComponent<Renderer>().material = mat[count];
                        GameObject cub = Instantiate(cube[index], new Vector3(prop[count].transform.position.x, +1, prop[count].transform.position.z), Quaternion.identity) as GameObject;
                        cub.transform.parent = transform;

                        //cube[index].transform.SetParent(transform);

                        prop[count].transform.position = cube[index].transform.position;
                     // prop[count].transform.position = new Vector3(prop[count].transform.position.x, +1, prop[count].transform.position.z);
                       // Instantiate(prop[count], prop[count].transform.position, Quaternion.identity);

                        GameObject obj= Instantiate(prop[count], new Vector3(prop[count].transform.position.x, +1, prop[count].transform.position.z), Quaternion.identity) as GameObject;
                       obj.transform.parent = transform;
                        //prop[count].transform.SetParent(transform);


                    }


                }

            }

        }


    }



}



    

