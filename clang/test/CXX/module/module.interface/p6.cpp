// The test is check we couldn't export a redeclaration which isn't exported previously and
// check it is OK to redeclare no matter exported nor not if is the previous declaration is exported.
// RUN: %clang_cc1 -std=c++20 %s -verify

export module X;

struct S { // expected-note {{previous declaration is here}}
  int n;
};
typedef S S;
export typedef S S; // OK, does not redeclare an entity
export struct S;    // expected-error {{cannot export redeclaration 'S' here since the previous declaration is not exported}}

namespace A {
struct X; // expected-note {{previous declaration is here}}
export struct Y;
} // namespace A

namespace A {
export struct X; // expected-error {{cannot export redeclaration 'X' here since the previous declaration is not exported}}
export struct Y; // OK
struct Z;        // expected-note {{previous declaration is here}}
export struct Z; // expected-error {{cannot export redeclaration 'Z' here since the previous declaration is not exported}}
} // namespace A

namespace A {
struct B;    // expected-note {{previous declaration is here}}
struct C {}; // expected-note {{previous declaration is here}}
} // namespace A

namespace A {
export struct B {}; // expected-error {{cannot export redeclaration 'B' here since the previous declaration is not exported}}
export struct C;    // expected-error {{cannot export redeclaration 'C' here since the previous declaration is not exported}}
} // namespace A

template <typename T>
struct TemplS; // expected-note {{previous declaration is here}}

export template <typename T>
struct TemplS {}; // expected-error {{cannot export redeclaration 'TemplS' here since the previous declaration is not exported}}

template <typename T>
struct TemplS2; // expected-note {{previous declaration is here}}

export template <typename U>
struct TemplS2 {}; // expected-error {{cannot export redeclaration 'TemplS2' here since the previous declaration is not exported}}

void baz();        // expected-note {{previous declaration is here}}
export void baz(); // expected-error {{cannot export redeclaration 'baz' here since the previous declaration is not exported}}

namespace A {
export void foo();
void bar();        // expected-note {{previous declaration is here}}
export void bar(); // expected-error {{cannot export redeclaration 'bar' here since the previous declaration is not exported}}
void f1();         // expected-note {{previous declaration is here}}
} // namespace A

// OK
//
// [module.interface]/p6
// A redeclaration of an entity X is implicitly exported if X was introduced by an exported declaration
void A::foo();

// The compiler couldn't export A::f1() here since A::f1() is declared above without exported.
// See [module.interface]/p6 for details.
export void A::f1(); // expected-error {{cannot export redeclaration 'f1' here since the previous declaration is not exported}}

template <typename T>
void TemplFunc(); // expected-note {{previous declaration is here}}

export template <typename T>
void TemplFunc() { // expected-error {{cannot export redeclaration 'TemplFunc' here since the previous declaration is not exported}}
}

namespace A {
template <typename T>
void TemplFunc2(); // expected-note {{previous declaration is here}}
export template <typename T>
void TemplFunc2() {} // expected-error {{cannot export redeclaration 'TemplFunc2' here since the previous declaration is not exported}}
template <typename T>
void TemplFunc3(); // expected-note {{previous declaration is here}}
} // namespace A

export template <typename T>
void A::TemplFunc3() {} // expected-error {{cannot export redeclaration 'TemplFunc3' here since the previous declaration is not exported}}

int var;        // expected-note {{previous declaration is here}}
export int var; // expected-error {{cannot export redeclaration 'var' here since the previous declaration is not exported}}

template <typename T>
T TemplVar; // expected-note {{previous declaration is here}}
export template <typename T>
T TemplVar; // expected-error {{cannot export redeclaration 'TemplVar' here since the previous declaration is not exported}}
