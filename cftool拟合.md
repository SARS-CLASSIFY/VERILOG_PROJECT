- polynomial 多项式拟合，选择阶数  
  - 2阶为例      f(x) = p1*x^2 + p2*x + p3

```
· Custom Equations：用户自定义的函数类型
· Exponential：指数逼近，有2种类型， a*exp(b*x) 、 a*exp(b*x) + c*exp(d*x)
· Fourier：傅立叶逼近，有7种类型，基础型是 a0 + a1*cos(x*w) + b1*sin(x*w)
· Gaussian：高斯逼近，有8种类型，基础型是 a1*exp(-((x-b1)/c1)^2)
· Interpolant：插值逼近，有4种类型，linear、nearest neighbor、cubic spline、shape-preserving
· Polynomial：多形式逼近，有9种类型，linear ~、quadratic ~、cubic ~、4-9th degree ~
· Power：幂逼近，有2种类型，a*x^b 、a*x^b + c
· Rational：有理数逼近，分子、分母共有的类型是linear ~、quadratic ~、cubic ~、4-5th degree ~；此外，分子还包括constant型
· Smoothing Spline：平滑逼近（翻译的不大恰当，不好意思）
· Sum of Sin Functions：正弦曲线逼近，有8种类型，基础型是 a1*sin(b1*x + c1)
· Weibull：只有一种，a*b*x^(b-1)*exp(-a*x^b)
```

- 拟合之后Save to workspace，可保存拟合后的结果函数

  并且可调用拟合函数

- 导入EXCEL数据

  - ​    num = xlsread(filename,sheet,xlRange) 可导入数值矩阵

  - 编写自定义函数读入数据并存在两列中

    ```matlab
    function [datax,datay] = my_xlsread(filename,sheet,xlsrange)
    data = xlsread(filename,sheet,xlsrange);
    datax = data(:,1);%读取第一列
    datay = data(:,2);%读取第二列
    end
    ```

    调用示例：[x1,y1] = my_xlsread("x.xlsx","sheet1","A2:B9");

